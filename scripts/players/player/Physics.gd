extends Node

#inputs
var leftPressed
var rightPressed
var jumpPressed

#physics
var motion = Vector2(0,0)
var aceleration
var maxSpeed
var jumpForce
var gravity
var friction
var airResistance

#flags
var isOnFloor

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
	
	if isOnFloor:
		motion.y = gravity
		
		if leftPressed:
			motion.x = clamp(motion.x - aceleration, -maxSpeed, 0)
		elif rightPressed:
			motion.x = clamp(motion.x + aceleration, 0, maxSpeed)
		else:
			motion.x = lerp(motion.x, 0, friction)
			
		if jumpPressed:
			motion.y  = -jumpForce
	elif not isOnFloor:
		motion.x = lerp(motion.x, 0, airResistance)
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
	aceleration = physics['aceleration']
	maxSpeed = physics['maxSpeed']
	jumpForce = physics['jumpForce']
	gravity = physics['gravity']
	friction = physics['friction']
	airResistance = physics['airResistance']
	
	#flags
	isOnFloor = flags['isOnFloor']
