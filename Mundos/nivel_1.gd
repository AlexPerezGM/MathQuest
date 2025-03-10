extends Node
var player = load("res://Player/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var newplayer = player.instantiate()
	newplayer.position = $spawn.position
	add_child(newplayer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
