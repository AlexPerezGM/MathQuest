extends Node
class_name  global
var moneda = 0 : 
	set(val):
		moneda = val
		if player != null:
			player.actualizacionInterfaceMoneda()
			$Moneda.play()
	get :
		return moneda
		
var player 
			
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
