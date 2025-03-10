extends Control
@onready var pregunta_label =$Label
@onready var respuesta_entrante = $LineEdit
@onready var aceptar_boton = $Button

var respuesta_correcta = 0
var enemigo_referencia =null 
var jugador = null

func _ready():
	hide()
	aceptar_boton.pressed.connect(_on_button_pressed)

func show_question (enemigo, pregunta, respuesta):
	respuesta_entrante.text = ""
	enemigo_referencia = enemigo
	jugador = Global.player
	pregunta_label.text = pregunta
	respuesta_correcta  = respuesta 
	
	jugador.iniciar_interaccion()
	show()

func _on_button_pressed():
	var respuesta_jugador = int(respuesta_entrante.text)
	
	if respuesta_jugador == respuesta_correcta:
		if enemigo_referencia is Enemy:
			print("respuesta correcta")
			jugador.terminar_interaccion()
			enemigo_referencia.dead()
		elif enemigo_referencia is Cofre:
			enemigo_referencia.abrir_cofre()
			jugador.terminar_interaccion()
		elif enemigo_referencia is Puerta:
			enemigo_referencia.pregunta_correcta()
			jugador.terminar_interaccion()
		elif enemigo_referencia is Lanzaguisantes:
			enemigo_referencia.dead()
			jugador.terminar_interaccion()
		hide()
	else: 
		if enemigo_referencia is Enemy:
			var player = get_tree().get_first_node_in_group("jugador")
			if player:
				player._on_hit(5)
			if player.vida < 0:
				hide()
	print("Incorrecto")
