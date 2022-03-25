extends Node


var leftButton = 14
var rightButton = 15
var jumpButton1 = 0
var jumpButton2 = 2

func run(playerIndex):
	
	var inputBundle = {
		'leftPressed' : false,
		'rightPressed' : false,
		'jumpPressed' : false
	}
	
	if leftIsPressed(playerIndex):
		inputBundle['leftPressed'] = true
	elif rightIsPressed(playerIndex):
		inputBundle['rightPressed'] = true
	
	if jumpIsPressed(playerIndex):
		inputBundle['jumpPressed'] = true
		
	return inputBundle


func leftIsPressed(playerIndex):
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		return true
	if Input.is_joy_button_pressed(playerIndex, leftButton) and not Input.is_joy_button_pressed(playerIndex, rightButton):
		return true

func rightIsPressed(playerIndex):
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		return true
	if Input.is_joy_button_pressed(playerIndex, rightButton) and not Input.is_joy_button_pressed(playerIndex, leftButton):
		return true

func jumpIsPressed(playerIndex):
	if Input.is_action_just_pressed("jump"):
		return true
	if Input.is_joy_button_pressed(playerIndex, jumpButton1):
		return true
	if Input.is_joy_button_pressed(playerIndex, jumpButton2):
		return true
