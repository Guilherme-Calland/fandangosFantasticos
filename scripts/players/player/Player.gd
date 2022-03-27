extends KinematicBody2D

export var playerIndex = 0
export var aceleration = 2.5
export var maxSpeed = 100
export var jumpForce = 150
export var horizontalImpulseForce = 75

export var face = preload("res://resources/spriteFrame/face/Face1.tres") setget setFace
export var body = preload("res://resources/spriteFrame/body/Body1.tres") setget setBody
export var bag = preload("res://resources/spriteFrame/Empty.tres") setget setBag
export var sword = preload("res://resources/spriteFrame/Empty.tres") setget setSword

var gameBundle

var gravity
var friction
var airResistance

func _ready():
	initBundle()
	setAllSprites()

func run(worldBundle):
	unpackWorldBundle(worldBundle)
	$Input.run(playerIndex)
	$Animation.run(gameBundle)
	$Physics.run(gameBundle)
	move_and_slide($Physics.motion, Vector2(0,-1))
	updateBundle()

func updateBundle():
	gameBundle['inputs'] = $Input.inputs
	gameBundle['physics'] = {
		'motion': $Physics.motion,
		'aceleration': aceleration, 
		'maxSpeed': maxSpeed, 
		'jumpForce': jumpForce, 
		'horizontalImpulseForce': horizontalImpulseForce,
		'gravity': gravity,
		'friction': friction,
		'airResistance' : airResistance
		}
	gameBundle['flags'] = {'isOnFloor': is_on_floor()}
	
func initBundle():
	gameBundle = {
		'inputs' : $Input.inputs,
		'physics' : {'motion': Vector2(0,0), 'speed': 0, 'jumpForce': 0, 'horizontalImpulseForce': horizontalImpulseForce, 'gravity': 0, 'friction': 0, 'airResistance': 0},
		'flags' : {'isOnFloor': false},
		'animation' : {'face': $Sprites/Face, 'body' : $Sprites/Body, 'bag' : $Sprites/Bag, 'sword': $Sprites/Sword}
	}

func unpackWorldBundle(worldBundle):
	gravity = worldBundle['gravity']
	friction = worldBundle['friction']
	airResistance = worldBundle['airResistance']

func setAllSprites():
	$Sprites/Face.set_sprite_frames(face)
	$Sprites/Body.set_sprite_frames(body)
	$Sprites/Bag.set_sprite_frames(bag)
	$Sprites/Sword.set_sprite_frames(sword)

func setFace(newFace):
	face = newFace
	setAllSprites()
	
func setBody(newBody):
	body = newBody
	setAllSprites()

func setBag(newBag):
	bag = newBag
	setAllSprites()

func setSword(newSword):
	sword = newSword
	setAllSprites()
