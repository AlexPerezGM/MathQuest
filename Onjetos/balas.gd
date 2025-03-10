extends Area2D

func _process(_delta):
	position.x -= 2


func _on_body_entered(body):
	if body is Player:
		body._on_hit(10)
		queue_free()
	else:
		queue_free()
