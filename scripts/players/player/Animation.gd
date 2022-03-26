extends Node

#inputs
var leftPressed
var rightPressed

#physics
var motion

#flags
var isOnFloor

#animation
var face
var body
var bag
var sword

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
	
	if leftPressed:
		flipSpriteHorizontal(true)
		
	elif rightPressed:
		flipSpriteHorizontal(false)
		
	if isOnFloor:
		if motion.x != 0:
			playAnimation("run")
		elif motion.x == 0:
			playAnimation("idle")
	elif not isOnFloor:
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
