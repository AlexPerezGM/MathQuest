extends CharacterBody2D
class_name Player

var speed = 120
var direccion = 0.0 
const GRAVITY := 25
var jump := 350
var en_interaccion =  false
var vida:int  = 50
var axis :Vector2 = Vector2.ZERO 

@onready var anim = $AnimationPlayer
@onready var sprite =  $Sprite2D
@onready var spawn_position = global_position
@onready var monedalabel = $PlayerGUI/HBoxContainer/MonedaLabel
@onready var vida_label = $PlayerGUI/HBoxContainer2/VidaLabel


func _ready():
	Global.player = self
	actualizar_interface_vida()
	

func _physics_process(_delta):
	#detiene el movimiento cuando va a responder una pregunta
	if en_interaccion:
		velocity = Vector2.ZERO
		anim.play("Idle")
		return
		
	#Movieminto normal del personaje
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
	
	if anim.current_animation == "Dano" or anim.current_animation == "Muerte":
		return
	
	if direccion != 0:
		anim.play("Wark")
	else:
		anim.play("Idle")
		
	#determian si el personaje va a la derecha o izquierda
	sprite.flip_h = direccion < 0 if direccion !=0 else sprite.flip_h
	#saltar
	if is_on_floor() and Input.is_action_pressed("ui_accept"):
		$Salto.play()
		anim.play("Salto")
		velocity.y -= jump
	#Controla la gravedad del personaje
	if !is_on_floor():
		velocity.y += GRAVITY
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down") and is_on_floor():
		position.y += 1.5

func iniciar_interaccion():
	en_interaccion = true
func terminar_interaccion():
	en_interaccion = false

func actualizacionInterfaceMoneda():
	$PlayerGUI/HBoxContainer/MonedaLabel.text = str(Global.moneda) 

func _on_hit(cantidad, trampa_pos = null, origen = null):
	if vida <= 0:
		return
		
	vida -= cantidad
	actualizar_interface_vida()
	
	if origen == "trampa" and trampa_pos:
		var direccion_knockback = sign(global_position.x - trampa_pos.x)
		velocity = Vector2(direccion_knockback * 1000, - 200)
		move_and_slide()
	if vida > 0 : 
		print("Recibe dano")
		anim.play("Dano")
	else:
		terminar_interaccion()
		print("judador muerto")
		anim.play("Muerte")
		await  anim.animation_finished
		get_tree().reload_current_scene()
		respawn()
		
func respawn():
	global_position = spawn_position
	vida = 50 
	Global.moneda = 0
	actualizacionInterfaceMoneda()
	actualizar_interface_vida()
	en_interaccion = false
	anim.play("Idle")
		
		
func actualizar_interface_vida():
	vida_label.text = "Vida: " + str(vida)
