extends Area2D
@export var velocidad = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += velocidad * delta
	
func _on_body_entered(body):
	if body is Player:
		body._on_hit(10)
		queue_free()
