extends CharacterBody2D

class_name Puerta

var abierta = false 
var operation = ""
var respuesta_correcta:int = 0

@onready var label =$Label
@onready var anim =$AnimationPlayer
var level0 = "res://Mundos/nivel_0.tscn"
var level1 = "res://Mundos/nivel_1.tscn"
var level2 = "res://Mundos/nivel_2.tscn"
@export var spawn_offset: Vector2

func _ready():
	anim.play("Cerrado")
	generar_problema()
	
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
	
func abrir_puerta():
	abierta = true
	anim.play("Abierta")
	
func pregunta_correcta():
	print("Respuesta correcta")
	abrir_puerta()
	

func _on_area_2d_body_entered(body):
	if body is Player and abierta == false:
		var math_popup = get_tree().get_first_node_in_group("mathpopup")
		math_popup.show_question(self, operation, respuesta_correcta)
	elif body is Player and abierta == true:
		if GlobalNivel.current_level == "level0":
			GlobalNivel.current_level = "level1"
			get_tree().change_scene_to_file(level1)
		elif GlobalNivel.current_level == "level1":
			GlobalNivel.current_level = "level2"
			get_tree().change_scene_to_file(level2)
		elif GlobalNivel.current_level =="level2":
			get_tree().change_scene_to_file("res://Menu/juego_terminado.tscn")

