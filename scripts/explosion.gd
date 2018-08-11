extends RigidBody2D

var tilemap

func _ready():
	$AnimationPlayer.play("explode")
	tilemap = get_tree().get_root().get_node("main").get_node("TileMap")


func _integrate_forces(state):
	
	var found = []

	for i in range(state.get_contact_count()):
		if state.get_contact_collider_object(i) == tilemap:
			var hit = tilemap.world_to_map(state.get_contact_collider_position(i))
			if not found.has(hit):
				found.append(hit)
		
	while not found.empty():
		var loc = found.pop_back()
		tilemap.replace_tile(loc)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()