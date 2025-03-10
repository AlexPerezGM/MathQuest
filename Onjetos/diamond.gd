extends Area2D
class_name Diamonds

@export var valor: int = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body is Player:
		Global.moneda += valor
		body.actualizacionInterfaceMoneda()
		queue_free()

