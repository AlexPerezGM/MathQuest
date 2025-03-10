extends Node2D
class_name  Cofre
var abierto = false
var operation = ""
var respuesta_correcta: int = 0
@export var recompensas: int = 3
@export var coin_scene: PackedScene  # Referencia a la escena de la moneda
@onready var label = $Label
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D

func _ready():
	generar_problema()

func _on_area_2d_body_entered(body):
	if body is Player and abierto == false:
		var math_popup = get_tree().get_first_node_in_group("mathpopup")
		math_popup.show_question(self, operation, respuesta_correcta)

func generar_problema():
	var signos = ["+","-", "*"]
	var num1 = randi()%10 + 1
	var num2 = randi()%10 +1
	var tipo_operacion = signos[randi()%signos.size()]
	
	match tipo_operacion:
		"+":
			respuesta_correcta = num1 + num2 
			operation = str(num1) + " + " + str(num2) + " =? "
		"-":
			respuesta_correcta = num1 - num2 
			operation = str(num1) + " - " + str(num2) + " =? "
		"*":
			respuesta_correcta = num1 * num2 
			operation = str(num1) + " * " + str(num2) + " =? "
	label.text = operation
	
func abrir_cofre():
	abierto = true
	anim.play("Abrir")
	
	for i in range(recompensas):
		var moneda = preload("res://Onjetos/diamond.tscn").instantiate()
		moneda.global_position =  global_position + Vector2(-130,-50)  # Posiciona la moneda cerca del cofre
		moneda.valor = randi()% 50 +100
		get_parent().add_child(moneda)
