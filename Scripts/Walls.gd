extends Node2D

var block_size # 60 x 60 It is defined in Tetrico script
var blocks # $Blocks Node2D
#var blocks_grid # Array made with rows and columns arrays
var n_columns
var n_rows
var tetrico # Parent node

# Called when the node enters the scene tree for the first time.
func _ready():
	self.blocks = $Blocks
	self.tetrico = get_parent()
	self.block_size = tetrico.block_size

#func _process(delta):
#	pass
		

func init(number_of_columns, number_of_rows):
	self.n_columns = number_of_columns
	self.n_rows = number_of_rows
#	self.blocks_grid = create_blocks_grid()

#func create_blocks_grid():
#	var grid = []
#	for row in range(self.n_rows):
#		grid.append([])
#		for column in range(self.n_columns):
#			grid[row].append([])
#	return grid

func build_blocks(tetrominio_blocks, blocks_positions):
	for i in range(tetrominio_blocks.size()):
		var block = tetrominio_blocks[i]
		var block_position = blocks_positions[i]
		var block_rotation = block.rotation_degrees
		build_block(block, block_position, block_rotation)
	check_for_competed_rows()
#	remove_completed_rows()
			
func build_block(tetrominio_block, block_position, block_rotation):
	var new_block = tetrominio_block.duplicate()
	new_block.position = block_position
	new_block.rotation_degrees = block_rotation
	var block_column_number = int(block_position.x) / block_size
	var block_row_number    = int(block_position.y) / block_size
#	set_block_position(block_row_number, block_column_number)
	add_block_shape_to_row(new_block, block_row_number)

#func set_block_position(block_row_number, block_column_number):
#	self.blocks_grid[block_row_number][block_column_number] = 1

func add_block_shape_to_row(block, block_row_number):
	var block_row_node = blocks.find_node("Row"+str(block_row_number))
	if block_row_node:
		block_row_node.add_child(block)
	else:
		block_row_node = create_block_row(block_row_number)
		block_row_node.add_child(block)

func create_block_row(row_number):
	var row_node = StaticBody2D.new()
	row_node.name = "Row" + str(row_number)
	self.blocks.add_child(row_node)
	return row_node

# Parei aqui tentando verificar quais linhas estão completas
func check_for_competed_rows():
	var rows = blocks.get_children()
	print(rows)
#	var completed_rows_numbers = []
#	for row in self.blocks_grid:
#		var blocks_in_row = 0
#		for column in row:
#			print(column)
	
func remove_completed_row(rows):
	for row in rows:
		row.queue_free()
