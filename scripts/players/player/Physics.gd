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
var gravity
var friction
var airResistance
var XYProportion

#flags
var isOnFloor
var isOnWall
var isOnCeiling
var impulseLock

#localFlags
var jumpLock = false
var wallJumpLock = false

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
	
	$JumpTimer.wait_time = jumpForce/400
	
	if isOnFloor:
		if jumpLock:
			if $JumpTimer.is_stopped():
				$JumpTimer.start()
		else: 
			$JumpTimer.stop()
		
		if abs(motion.x) < 1:
			emit_signal("impulseLock", false)
		
		motion.y = gravity
		
		if leftPressed and not secondaryActionPressed and not impulseLock and not jumpLock:
			motion.x = clamp(motion.x - aceleration, -maxSpeed, 0)
		elif rightPressed and not secondaryActionPressed and not impulseLock and not jumpLock:
			motion.x = clamp(motion.x + aceleration, 0, maxSpeed)
		else:
			motion.x = lerp(motion.x, 0, friction)
			
		if jumpPressed and not impulseLock and not jumpLock:
			jumpLock = true
			
			var p = XYProportion
			var a = p*p + 1
			var axisForce = jumpForce*sqrt(a)/ a
			if secondaryActionPressed:
				emit_signal("impulseLock", true)
				if leftPressed:
					motion.x -= p*axisForce
					motion.y = -axisForce
				elif rightPressed:
					motion.x += p*axisForce
					motion.y = -axisForce
				else:
					motion.y = -jumpForce
			if not secondaryActionPressed:
				if leftPressed:
					motion.x -= axisForce
					motion.y  = -p*axisForce
				elif rightPressed:
					motion.x += axisForce
					motion.y  = -p*axisForce
				else:
					motion.y = -jumpForce
					
	elif not isOnFloor:
		motion.x = lerp(motion.x, 0, airResistance)
		motion.y += gravity
	
	if isOnWall:
#		if jumpLock:
#			if $JumpTimer.is_stopped():
#				$JumpTimer.start()
#			else: 
#				$JumpTimer.stop()

		if motion.x > 0:
			motion.x = 1
		elif motion.x < 0:
			motion.x = -1
		
#		if jumpPressed and not jumpLock:
		if jumpPressed:
#			jumpLock = true
			var p = 0.65
			var a = p*p + 1
			var axisForce = jumpForce*sqrt(a)/ a
			
			if motion.x > 0:
				motion.x -= p*axisForce
				motion.y = -axisForce
			elif motion.x < 0:
				motion.x += p*axisForce
				motion.y = -axisForce
	
	if isOnCeiling:
		motion.y = 1
	
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
	gravity = physics['gravity']
	friction = physics['friction']
	airResistance = physics['airResistance']
	XYProportion = physics['XYProportion']
	
	#flags
	isOnFloor = flags['isOnFloor']
	isOnWall = flags['isOnWall']
	isOnCeiling = flags['isOnCeiling']
	impulseLock = flags['impulseLock']

func _on_JumpTimer_timeout():
	jumpLock = false
