extends Node

#inputs
var leftPressed
var rightPressed
var secondaryActionPressed

#physics
var motion
var maxSpeed

#flags
var isOnFloor
var isOnWall
var facingLeft

#animation
var face
var body
var bag
var sword

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
	
	if facingLeft:
		flipSpriteHorizontal(true)
	elif not facingLeft:
		flipSpriteHorizontal(false)
	
	if isOnFloor and not isOnWall:
		if (leftPressed or rightPressed) and abs(motion.x) > 1 and not secondaryActionPressed:
			setFrameSpeed(abs(motion.x/maxSpeed))
			playAnimation("run")
		else:
			setFrameSpeed(1)
			playAnimation("idle")
	elif not isOnFloor:
		playAnimation("jump")
	
	if isOnWall:
		playAnimation("touch")
	
func unpackBundle(gameBundle):
	var inputs = gameBundle['inputs']
	var physics = gameBundle['physics']
	var flags = gameBundle['flags']
	var animation = gameBundle['animation']
	
	#inputs
	leftPressed = inputs['leftPressed']
	rightPressed = inputs['rightPressed']
	secondaryActionPressed = inputs['secondaryActionPressed']
	
	#physics
	motion = physics['motion']
	maxSpeed = physics['maxSpeed']
	
	#flags
	isOnFloor = flags['isOnFloor']
	isOnWall = flags['isOnWall']
	facingLeft = flags['facingLeft']

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
