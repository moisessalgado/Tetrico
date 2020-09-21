extends Node2D

var block_size = 60# x 60
var screen_size
var tetrominio = null
var tetrominios = [
	"res://Scenes/Tetrominio_I.tscn",
	"res://Scenes/Tetrominio_O.tscn",
	"res://Scenes/Tetrominio_T.tscn"
]
var walls

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	$TimeToMoveDown.start()
	$TimeToMove.start()
	walls = $Walls
	var columns = screen_size.x / block_size
	var rows    = screen_size.y / block_size
	walls.init(columns, rows)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_tetrominio()


func spawn_tetrominio():
	if tetrominio == null:
		var tetrominio_scene = load(str(tetrominios[randi() % tetrominios.size()]))
		tetrominio = tetrominio_scene.instance()
		var initial_position = Vector2(330, 60)
		tetrominio.init(block_size, initial_position)
		add_child(tetrominio)


func _on_TimeToMoveDown_timeout():
	var collision
	if tetrominio != null:
		collision = tetrominio.move_down()
		if collision:
			walls.build_blocks(tetrominio)
			tetrominio.destroy()
			tetrominio = null
			pass


func _on_TimeToMove_timeout():
	if tetrominio != null:
		tetrominio.move()
