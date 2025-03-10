extends CharacterBody2D
class_name Enemy

@export_group("Options")
@export var vida: int = 2
@export var score: int = 100
@onready var anim = $AnimationPlayer

@export_group("Motion")
@export var speed: = 50
@export var gravity : int = 25

var direccion: int = 1
var operation: String = ""
var respuesta_correcta: int = 0
var en_interaccion = false
var control_reference= null
@onready var label = $Label

func _ready():
	generar_problema()

func _process(_delta):
	if vida > 0: 
		motion_ctrl()
		
func motion_ctrl():
	if anim.current_animation == "Morir" :
		return
		
	if en_interaccion:
		velocity.x = 0
		anim.play("Idle")
		return
		
	$Sprite2D.scale.x = direccion
	
	if direccion != 0:
		anim.play("Caminar")
		
	if not $Sprite2D/RayCast2D.is_colliding() or is_on_wall():
		direccion *= -1
	velocity.x = direccion *speed
	if not is_on_floor():
		velocity.y += gravity
	move_and_slide()
	
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

func dead():
	anim.play("Morir")
	await anim.animation_finished
	queue_free()
	Global.moneda += 100

func _on_area_2d_body_entered(body):
	print("Colision detectada")
	if body is Player:
		var math_popup = get_tree().get_first_node_in_group("mathpopup")
		print("WII")
		
		en_interaccion = true
		body.iniciar_interaccion()
		math_popup.show_question(self, operation, respuesta_correcta)
		
