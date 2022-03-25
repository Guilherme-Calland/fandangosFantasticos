extends Node

#inputs
var leftPressed
var rightPressed

#physics
var motion

#flags
var isOnFloor

#animation
var sprite

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
	
	if leftPressed:
		sprite.flip_h = true
	elif rightPressed:
		sprite.flip_h = false
		
	if isOnFloor:
		if motion.x != 0:
			sprite.play("run")
		elif motion.x == 0:
			sprite.play("idle")
	elif not isOnFloor:
		sprite.play('jump')
	
func unpackBundle(gameBundle):
	var inputs = gameBundle['inputs']
	var physics = gameBundle['physics']
	var flags = gameBundle['flags']
	
	#inputs
	leftPressed = inputs['leftPressed']
	rightPressed = inputs['rightPressed']
	
	#physics
	motion = physics['motion']
	
	#flags
	isOnFloor = flags['isOnFloor']

	#animation
	sprite = gameBundle['sprite']
