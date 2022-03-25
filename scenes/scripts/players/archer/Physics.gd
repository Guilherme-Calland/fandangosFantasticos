extends Node

#inputs
var leftPressed
var rightPressed
var jumpPressed

#physics
var motion = Vector2(0,0)
var speed
var gravity
var jumpForce

#flags
var isOnFloor

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
	
	if leftPressed:
		motion.x = -speed
	elif rightPressed:
		motion.x = speed
	else:
		motion.x = 0
	
	if isOnFloor:
		motion.y = gravity
		if jumpPressed:
			motion.y  = -jumpForce
	elif not isOnFloor:
		motion.y += gravity
	

func unpackBundle(gameBundle):
	var inputs = gameBundle['inputs']
	var physics = gameBundle['physics']
	var flags = gameBundle['flags']
	
	#inputs
	leftPressed = inputs['leftPressed']
	rightPressed = inputs['rightPressed']
	jumpPressed = inputs['jumpPressed']
	
	#physics
	motion = physics['motion']
	speed = physics['speed']
	gravity = physics['gravity']
	jumpForce = physics['jumpForce']
	
	#flags
	isOnFloor = flags['isOnFloor']
