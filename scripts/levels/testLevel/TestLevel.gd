extends Node2D

export var gravity = 10
export var friction = 0.1
export var airResistance = 0.1

var worldBundle

func _process(delta):
	packWorldBundle()
	$Player1.run(worldBundle)

func packWorldBundle():
	worldBundle = {
	'gravity' : gravity,
	'friction' : friction,
	'airResistance' : airResistance
	}
