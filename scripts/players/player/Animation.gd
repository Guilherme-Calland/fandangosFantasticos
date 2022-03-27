extends Node

#inputs
var leftPressed
var rightPressed
var jumpPressed
var secondaryActionPressed

#physics
var motion
var maxSpeed

#flags
var isOnFloor
var isOnWall
var impulseLock

#animation
var face
var body
var bag
var sword

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
		
	if isOnFloor and not isOnWall:
		if leftPressed and not secondaryActionPressed and not impulseLock:
			setFrameSpeed(abs(motion.x/maxSpeed))
			flipSpriteHorizontal(true)
			playAnimation("run")
		elif rightPressed and not secondaryActionPressed and not impulseLock:
			setFrameSpeed(abs(motion.x/maxSpeed))
			flipSpriteHorizontal(false)
			playAnimation("run")
		else:
			playAnimation("idle")
			setFrameSpeed(1)
	elif not isOnFloor:
		playAnimation("jump")
	
	if isOnWall:
		playAnimation("touch")
		if jumpPressed:
			flipSpriteHorizontal(!body.flip_h)
	
func unpackBundle(gameBundle):
	var inputs = gameBundle['inputs']
	var physics = gameBundle['physics']
	var flags = gameBundle['flags']
	var animation = gameBundle['animation']
	
	#inputs
	leftPressed = inputs['leftPressed']
	rightPressed = inputs['rightPressed']
	jumpPressed = inputs['jumpPressed']
	secondaryActionPressed = inputs['secondaryActionPressed']
	
	#physics
	motion = physics['motion']
	maxSpeed = physics['maxSpeed']
	
	#flags
	isOnFloor = flags['isOnFloor']
	isOnWall = flags['isOnWall']
	impulseLock = flags['impulseLock']

	#animation
	face = animation['face']
	body = animation['body']
	bag = animation['bag']
	sword = animation['sword']

func flipSpriteHorizontal(b):
	face.flip_h = b
	body.flip_h = b
	bag.flip_h = b
	sword.flip_h = b

func playAnimation(animation):
	face.play(animation)
	body.play(animation)
	bag.play(animation)
	sword.play(animation)

func setFrameSpeed(m):
	face.set_speed_scale(m)
	body.set_speed_scale(m)
	bag.set_speed_scale(m)
	sword.set_speed_scale(m)
