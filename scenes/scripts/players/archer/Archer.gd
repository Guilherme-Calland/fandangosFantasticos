extends KinematicBody2D

var motion = Vector2(0,0)
export var playerIndex = 0
export var speed = 100
export var jumpForce = 150

var inputBundle

func run(gravity):
	inputBundle = $Input.run(playerIndex)
	if inputBundle['leftPressed']:
		motion.x = -speed
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	elif inputBundle['rightPressed']:
		motion.x = speed
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
		motion.x = 0
		
	if is_on_floor():
		motion.y = gravity
		if inputBundle['jumpPressed']:
			motion.y = -jumpForce
	elif not is_on_floor():
		$AnimatedSprite.play('jump')
		motion.y += gravity
		
	move_and_slide(motion, Vector2(0,-1))
