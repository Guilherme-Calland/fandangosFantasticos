extends KinematicBody2D

var motion = Vector2(0,0)
export var speed = 100

func run():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -speed
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = speed
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
		motion.x = 0
	move_and_slide(motion, Vector2(0,-1))
