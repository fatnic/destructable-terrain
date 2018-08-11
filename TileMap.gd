extends TileMap

var block = preload("res://entities/block.tscn")
var replaced = []

func _ready():
	pass


func replace_tile(tile):
	if not replaced.has(tile):
		replaced.append(tile)
		set_cell(tile.x, tile.y, -1)
		var b = block.instance()
		b.position.x = map_to_world(tile).x + cell_size.x / 2
		b.position.y = map_to_world(tile).y + cell_size.x / 2
		get_tree().get_root().get_node("main").add_child(b)