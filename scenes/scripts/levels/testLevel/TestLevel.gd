extends Node2D

export var gravity = 10

func _process(delta):
	$Archer.run(gravity)
