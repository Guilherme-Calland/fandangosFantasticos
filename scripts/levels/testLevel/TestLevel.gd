extends Node2D

export var gravity = 10
func _process(delta):
	$Player1.run(gravity)
	$Player2.run(gravity)
	$Player3.run(gravity)
