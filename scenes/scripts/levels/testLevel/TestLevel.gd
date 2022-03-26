extends Node2D

export var gravity = 10
func _process(delta):
	$Player1.run(gravity)
