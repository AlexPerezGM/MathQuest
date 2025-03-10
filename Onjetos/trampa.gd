extends CharacterBody2D

@export var fuerza: int = 10
@export var velocidad: int = 50 
@export var distancia: int = 50 
var direccion = 1 
var position_inicial = 0

func _ready():
	position_inicial = position
	
func _process(delta):
	position.x += velocidad * direccion *delta
	
	if abs(position.x - position_inicial.x) >= distancia:
		direccion *= -1

func _on_area_2d_body_entered(body):
	if body is Player: 
		body._on_hit(fuerza, global_position, "trampa")
