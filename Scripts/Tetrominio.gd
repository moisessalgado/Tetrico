extends KinematicBody2D

var block_size
var block1
var block2
var block3
var block4

func _ready():
	block1 = $CollisionShape2D1
	block2 = $CollisionShape2D2
	block3 = $CollisionShape2D3
	block4 = $CollisionShape2D4

func _process(delta):
	pass

func init(block_size, initial_position):
	self.block_size = block_size
	self.position = initial_position
	
func destroy():
	hide()
	queue_free()	

func get_blocks():
	var blocks = [block1, block2, block3, block4]
	return blocks

func get_blocks_positions():
	var positions = []
	positions.append(block1.position + self.position)
	positions.append(block2.position + self.position)
	positions.append(block3.position + self.position)
	positions.append(block4.position + self.position)
	return positions

func get_blocks_rotation():
	return self.rotation
	
func move_down():
	var collision = move_and_collide(Vector2(0, block_size))
	if collision:
		return true

func move():
	var left = Input.get_action_strength("ui_left")
	var right = Input.get_action_strength("ui_right")
	var x = (right + left * -1) * block_size
	var y = Input.get_action_strength("ui_down") * block_size
	move_and_collide(Vector2(x, y))
	if Input.get_action_strength("ui_up"):
		rotate(PI/2)
