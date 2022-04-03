extends Node2D

export var gravity = 10
export var friction = 0.1
export var airResistance = 0.01

var worldBundle

func _ready():
	$Camera2D.global_position = Vector2(57, -25)

func _process(delta):
	packWorldBundle()
	$Player.run(worldBundle)

func packWorldBundle():
	worldBundle = {
	'gravity' : gravity,
	'friction' : friction,
	'airResistance' : airResistance
	}

func _on_CameraTrigger_body_entered(body, position):
	$Camera2D.global_position = position

func _on_CameraTriggerAndTeleport_body_entered(body, position):
	$Player.global_position = Vector2(position.x - 100, position.y)
