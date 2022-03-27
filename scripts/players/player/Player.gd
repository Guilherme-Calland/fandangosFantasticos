extends KinematicBody2D

export var playerIndex = 0
export var aceleration = 2.5
export var maxSpeed = 100.0
export var jumpForce = 150.0
export var XYProportion = 3.0

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
	$Physics.connect("impulseLock", self, "impulseLock")

func run(worldBundle):
	unpackWorldBundle(worldBundle)
	$Input.run(playerIndex)
	$Animation.run(gameBundle)
	$Physics.run(gameBundle)
	move_and_slide($Physics.motion, Vector2(0,-1))
	updateBundle()
	
func initBundle():
	gameBundle = {
		'inputs' : $Input.inputs,
		'physics' : {'motion': Vector2(0,0), 'speed': 0, 'jumpForce': 0, 'gravity': 0, 'friction': 0, 'airResistance': 0, 'XYProportion': XYProportion},
		'flags' : {'isOnFloor': false, 'isOnWall': false, 'isOnCeiling': false, 'impulseLock': false},
		'animation' : {'face': $Sprites/Face, 'body' : $Sprites/Body, 'bag' : $Sprites/Bag, 'sword': $Sprites/Sword}
	}

func updateBundle():
	gameBundle['inputs'] = $Input.inputs
	gameBundle['physics'] = {
		'motion': $Physics.motion,
		'aceleration': aceleration, 
		'maxSpeed': maxSpeed, 
		'jumpForce': jumpForce, 
		'gravity': gravity,
		'friction': friction,
		'airResistance' : airResistance,
		'XYProportion' : XYProportion
		}
	gameBundle['flags']['isOnFloor'] = is_on_floor()
	gameBundle['flags']['isOnWall'] = is_on_wall()
	gameBundle['flags']['isOnCeiling'] = is_on_ceiling()
	
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

func impulseLock(val):
	gameBundle['flags']['impulseLock'] = val
