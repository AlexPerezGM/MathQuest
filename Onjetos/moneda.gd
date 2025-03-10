extends Area2D

@onready var anim = $AnimationPlayer
	

func _on_body_entered(body):
	if body is Player:
		Global.moneda+=1
		queue_free()
