extends Node2D

var block_size = 60# x 60
var screen_size
var tetrominio = null
var tetrominios = [
	"res://Scenes/Tetrominio_I.tscn",
	"res://Scenes/Tetrominio_O.tscn",
	"res://Scenes/Tetrominio_T.tscn"
]

func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	$SpawnPosition.position = Vector2(screen_size.x/2,0)
	$TimeToFall.start()
	$Wall.init()

func _process(delta):
	spawn_tetrominio()

func spawn_tetrominio():
	if tetrominio == null:
		var tetrominio_scene = load(str(tetrominios[randi() % tetrominios.size()]))
		tetrominio = tetrominio_scene.instance()
		tetrominio.init(block_size, $SpawnPosition)
		add_child(tetrominio)

func _on_TimeToFall_timeout():
	if tetrominio != null:
		var collision = tetrominio.fall()
		if collision:
			$Wall.build_blocks(tetrominio)
			tetrominio = tetrominio.destroy()
