extends Node

#signals
signal impulseLock

#inputs
var leftPressed
var rightPressed
var jumpPressed
var secondaryActionPressed

#physics
var motion = Vector2(0,0)
var aceleration
var maxSpeed
var jumpForce
var horizontalImpulseForce
var gravity
var friction
var airResistance

#flags
var isOnFloor
var impulseLock

#localFlags
var jumpLock = false

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
	
	$Timer.wait_time = jumpForce/200
	
	if isOnFloor:
		
		if abs(motion.x) < 1:
			emit_signal("impulseLock", false)
		
		motion.y = gravity
		
		if leftPressed and not secondaryActionPressed and not impulseLock:
			motion.x = clamp(motion.x - aceleration, -maxSpeed, 0)
		elif rightPressed and not secondaryActionPressed and not impulseLock:
			motion.x = clamp(motion.x + aceleration, 0, maxSpeed)
		else:
			motion.x = lerp(motion.x, 0, friction)
			
		if jumpPressed and not impulseLock and not jumpLock:
			jumpLock = true
			$Timer.start()
			if secondaryActionPressed:
				emit_signal("impulseLock", true)
				if leftPressed:
					motion.y = -jumpForce/4
					motion.x -= horizontalImpulseForce
				if rightPressed:
					motion.y = -jumpForce/4
					motion.x += horizontalImpulseForce
			if not secondaryActionPressed:
				motion.y  = -jumpForce
				if leftPressed:
					motion.x -= horizontalImpulseForce/16
				elif rightPressed:
					motion.x += horizontalImpulseForce/16
					
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
	secondaryActionPressed = inputs['secondaryActionPressed']
	
	#physics
	motion = physics['motion']
	aceleration = physics['aceleration']
	maxSpeed = physics['maxSpeed']
	jumpForce = physics['jumpForce']
	horizontalImpulseForce = physics['horizontalImpulseForce']
	gravity = physics['gravity']
	friction = physics['friction']
	airResistance = physics['airResistance']
	
	#flags
	isOnFloor = flags['isOnFloor']
	impulseLock = flags['impulseLock']


func _on_Timer_timeout():
	jumpLock = false
