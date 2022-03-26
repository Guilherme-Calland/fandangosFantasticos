extends KinematicBody2D

export var playerIndex = 0
export var speed = 75
export var jumpForce = 150

export var body = preload("res://resources/spriteFrame/body/Body1.tres")
export var face = preload("res://resources/spriteFrame/face/Face1.tres")
export var bag = preload("res://resources/spriteFrame/Empty.tres")

var gameBundle

var gravity

func _ready():
	initBundle()
	setSprites()

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
		'animation' : {'face': $Sprites/Face, 'body' : $Sprites/Body, 'bag' : $Sprites/Bag}
	}

func setSprites():
	$Sprites/Body.set_sprite_frames(body)
	$Sprites/Face.set_sprite_frames(face)
	$Sprites/Bag.set_sprite_frames(bag)
