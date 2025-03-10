extends CharacterBody2D
class_name Lanzaguisantes

@export var bala : PackedScene 
var puede_disparar = true
@onready var anim = $AnimationPlayer
var operation: String = ""
var respuesta_correcta: int = 0
var en_interaccion = false
var control_reference= null
@onready var label = $Label

func _ready():
	generar_problema()
	
func _process(_delta):
	if $RayCast2D.is_colliding():
		var obj = $RayCast2D.get_collider()
		if obj.is_in_group("jugador")and puede_disparar == true:
			puede_disparar = false
			$Timer.start()
			$Timer2.start()
			disparar()
	
func disparar():
	var newBala = bala.instantiate()
	newBala.global_position = $Spawn_bala.global_position
	get_parent().add_child(newBala)
	
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

func _on_timer_timeout():
	puede_disparar = true 

func animacion():
	anim.play("Disparar")
	
func _on_timer_2_timeout():
	animacion()
func dead():
	queue_free()
	Global.moneda += 250

func _on_area_2d_body_entered(body):
	print("Colision detectada")
	if body is Player:
		var math_popup = get_tree().get_first_node_in_group("mathpopup")
		print("WII")
		
		en_interaccion = true
		body.iniciar_interaccion()
		math_popup.show_question(self, operation, respuesta_correcta)
