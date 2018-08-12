extends TileMap

var block = preload("res://entities/block.tscn")
var replaced = []


func replace_tile(tile):

	if not replaced.has(tile):
		
		var current_tile = get_cellv(tile)
		set_cellv(tile, -1)
		
		var b = block.instance()
		b.get_node("Sprite").texture = tile_set.tile_get_texture(current_tile)
		b.position.x = map_to_world(tile).x + cell_size.x / 2
		b.position.y = map_to_world(tile).y + cell_size.x / 2
		$destruct_blocks.add_child(b)

		replaced.append(tile)
