extends RigidBody2D

var explosion = preload("res://entities/explosion.tscn")

func _ready():
	pass
	

func bang():
	var bang = explosion.instance()
	bang.position = global_position
	get_tree().get_root().add_child(bang)
	queue_free()


func _on_bomb_body_entered(body):
	bang()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
