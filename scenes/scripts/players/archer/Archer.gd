extends KinematicBody2D

export var playerIndex = 0
export var speed = 75
export var jumpForce = 150

var gameBundle

var gravity

func _ready():
	initBundle()

func run(inGravity):
	gravity = inGravity
	$Input.run(playerIndex)
	$Animation.run(gameBundle)
	$Physics.run(gameBundle)
	move_and_slide($Physics.motion, Vector2(0,-1))
	updateBundle()

func updateBundle():
	gameBundle['inputs'] = $Input.inputs
	gameBundle['physics'] = {'motion': $Physics.motion, 'speed': speed, 'jumpForce': jumpForce, 'gravity': gravity}
	gameBundle['flags'] = {'isOnFloor': is_on_floor()}
	
func initBundle():
	gameBundle = {
		'inputs' : $Input.inputs,
		'physics' : {'motion': Vector2(0,0), 'speed': 0, 'jumpForce': 0, 'gravity': 0},
		'flags' : {'isOnFloor': false},
		'sprite' : $AnimatedSprite
	}
