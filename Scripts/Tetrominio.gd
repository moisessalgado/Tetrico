extends KinematicBody2D

var block_color
var block_size

func _ready():
	$Timer.start()
	$Timer.connect("timeout", self, "_on_Timer_timeout")

#func _process(delta):
#	pass

func init(block_size, spawn_position):
	self.block_size = block_size
	self.position.x = spawn_position.position.x
	self.position.y = spawn_position.position.y
	
func destroy():
	hide()
	queue_free()
	return null

func get_blocks():
	var blocks = [$Block1, $Block2, $Block3, $Block4]
	return blocks

func get_blocks_positions():
	var positions = []
	positions.append($Block1.global_position)
	positions.append($Block2.global_position)
	positions.append($Block3.global_position)
	positions.append($Block4.global_position)
	return positions

func set_blocks_color(block_color):
	$Block1.sprite.modulate = block_color
	$Block2.sprite.modulate = block_color
	$Block3.sprite.modulate = block_color
	$Block4.sprite.modulate = block_color
	
func fall():
	var collision = move_and_collide(Vector2(0, block_size))
	if collision:
		return collision

func tetrominio_move():
	var left = Input.get_action_strength("ui_left")
	var right = Input.get_action_strength("ui_right")
	var x = (right + left * -1) * block_size
	var y = Input.get_action_strength("ui_down") * block_size
	move_and_collide(Vector2(x, y))

func tetrominio_rotate():
	var rotation_angle = PI/2
	if Input.get_action_strength("ui_up"):
		var t = Transform2D(rotation_angle, self.position)
		var collide = test_move(t, Vector2.ZERO)
		if not collide:
			rotate(rotation_angle)
	
func _on_Timer_timeout():
	tetrominio_move()
	tetrominio_rotate()
