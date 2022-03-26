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

func run(gameBundle):
	if gameBundle['inputs'] == null:
		return
	unpackBundle(gameBundle)
	
	if leftPressed:
		face.flip_h = true
		body.flip_h = true
	elif rightPressed:
		face.flip_h = false
		body.flip_h = false
		
	if isOnFloor:
		if motion.x != 0:
			face.play("run")
			body.play("run")
		elif motion.x == 0:
			face.play("idle")
			body.play("idle")
	elif not isOnFloor:
		face.play('jump')
		body.play('jump')
	
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
