extends Node2D

export var gravity = 10
export var friction = 0.1

func _process(delta):
	$Player1.run(gravity, friction)
