extends Node2D

var block_size # 60 x 60 defined in Tetrico script
var n_columns
var n_rows
var tetrico # Parent node

func _ready():
	self.tetrico = get_parent()

#func _process(delta):
#	pass
		

func init():
	self.block_size = tetrico.block_size
	self.n_columns = tetrico.screen_size.x / block_size
	self.n_rows = tetrico.screen_size.y / block_size

func build_blocks(tetrominio):
	var tetrominio_blocks = tetrominio.get_blocks()
	var tetrominio_blocks_positions = tetrominio.get_blocks_positions()
	for i in range(tetrominio_blocks.size()):
		var tetrominio_block = tetrominio_blocks[i]
		var block_position = tetrominio_blocks_positions[i]
		build_block(tetrominio_block, block_position)
	check_for_competed_rows()
#	remove_completed_rows()
			
func build_block(tetrominio_block, block_position):
	var wall_block = tetrominio_block.duplicate()
	wall_block.position = block_position
	var block_column_number = int(block_position.x) / block_size
	var block_row_number    = int(block_position.y) / block_size
#	set_block_position(block_row_number, block_column_number)
	add_block_shape_to_row(wall_block, block_row_number)

func add_block_shape_to_row(block, block_row_number):
	var block_row_node = $RowsOfBlocks.find_node("Row"+str(block_row_number))
	if block_row_node:
		block_row_node.add_child(block)
	else:
		block_row_node = create_block_row(block_row_number)
		block_row_node.add_child(block)

func create_block_row(row_number):
	var row_node = StaticBody2D.new()
	row_node.name = "Row" + str(row_number)
	$RowsOfBlocks.add_child(row_node)
	return row_node

func check_for_competed_rows():
	var rows = $RowsOfBlocks.get_children()
	for row in rows:
		print(row.name)
	
func remove_completed_row(rows):
	for row in rows:
		row.queue_free()
