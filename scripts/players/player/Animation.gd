extends Node

#inputs
var leftPressed
var rightPressed

#physics
var motion
var maxSpeed

#flags
var isOnFloor

#animation
var face
var body
var bag
var sword

#localFlags
var wasOnFloor = true

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
		
	if isOnFloor:
		if not wasOnFloor:
			playAnimation("jump")
		wasOnFloor = true
		if leftPressed:
			setFrameSpeed(abs(motion.x/maxSpeed))
			flipSpriteHorizontal(true)
			playAnimation("run")
		elif rightPressed:
			setFrameSpeed(abs(motion.x/maxSpeed))
			flipSpriteHorizontal(false)
			playAnimation("run")
		else:
			playAnimation("idle")
			setFrameSpeed(1)
			
	elif not isOnFloor:
		wasOnFloor = false
		playAnimation("jump")
	
func unpackBundle(gameBundle):
	var inputs = gameBundle['inputs']
	var physics = gameBundle['physics']
	var flags = gameBundle['flags']
	var animation = gameBundle['animation']
	
	#inputs
	leftPressed = inputs['leftPressed']
	rightPressed = inputs['rightPressed']
	
	#physics
	motion = physics['motion']
	maxSpeed = physics['maxSpeed']
	
	#flags
	isOnFloor = flags['isOnFloor']

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
