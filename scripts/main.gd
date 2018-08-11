extends Node2D

var bomb = preload("res://entities/bomb.tscn")

var cooldown = false

func _ready():
	pass
	
func _process(delta):
	
	if not cooldown and Input.is_action_pressed("left_mouse"):
		cooldown = true
		$explosion_cooldown.start()
		
		var bang = bomb.instance()
		bang.position = get_global_mouse_position()
		add_child(bang)


func _on_explosion_cooldown_timeout():
	cooldown = false