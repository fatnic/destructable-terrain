extends RigidBody2D

var block = preload("res://entities/block.tscn")

export (int, 2, 16) var min_quad = 2
export (Texture) var default_texture

func _ready():
	
	if default_texture:
		$Sprite.texture = default_texture
		
	var block_size = $Sprite.region_rect.size.x
	$CollisionShape2D.shape = RectangleShape2D.new()
	$CollisionShape2D.shape.extents = Vector2(block_size / 2.0, block_size / 2.0)
			
			
func split_block():
	
	var parent_size = $Sprite.region_rect.size.x
	var tex_off = $Sprite.region_rect.position
	var block_size = parent_size / 2
	var parent_texture = $Sprite.texture
	
	var nw = block.instance()
	nw.position = Vector2(position.x - (parent_size / 4), position.y - (parent_size / 4))
	nw.get_node("Sprite").texture = parent_texture
	nw.get_node("Sprite").region_rect = Rect2(Vector2(tex_off.x, tex_off.y), Vector2(block_size, block_size))
	get_tree().get_root().add_child(nw)
	
	var ne = block.instance()
	ne.position = Vector2(position.x + (parent_size / 4), position.y - (parent_size / 4))
	ne.get_node("Sprite").texture = parent_texture
	ne.get_node("Sprite").region_rect = Rect2(Vector2(tex_off.x + block_size, tex_off.y), Vector2(block_size, block_size))
	get_tree().get_root().add_child(ne)
	
	var sw = block.instance()
	sw.position = Vector2(position.x - (parent_size / 4), position.y + (parent_size / 4))
	sw.get_node("Sprite").texture = parent_texture
	sw.get_node("Sprite").region_rect = Rect2(Vector2(tex_off.x, tex_off.y + block_size), Vector2(block_size, block_size))
	get_tree().get_root().add_child(sw)
	
	var se = block.instance()
	se.position = Vector2(position.x + (parent_size / 4), position.y + (parent_size / 4))
	se.get_node("Sprite").texture = parent_texture
	se.get_node("Sprite").region_rect = Rect2(Vector2(tex_off.x + block_size, tex_off.y + block_size), Vector2(block_size, block_size))
	get_tree().get_root().add_child(se)

	queue_free()


func destruct():
	if get_node("Sprite").region_rect.size.x > min_quad:
		split_block()
	else:
		queue_free()


func _on_Base_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("explosion"):
		destruct()
#
		