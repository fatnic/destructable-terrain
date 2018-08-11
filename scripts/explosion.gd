extends RigidBody2D

func _ready():
	$AnimationPlayer.play("explode")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()