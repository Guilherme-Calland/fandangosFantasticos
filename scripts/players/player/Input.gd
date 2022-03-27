extends Node


const leftButton = 14
const rightButton = 15
const jumpButton1 = 0
const jumpButton2 = 2
const secondaryAction1 = 4
const secondaryAction2 = 6

var inputs

func run(playerIndex):
	
	inputs = {
		'leftPressed' : false,
		'rightPressed' : false,
		'jumpPressed' : false,
		'secondaryActionPressed' : false
	}
	
	if leftIsPressed(playerIndex):
		inputs['leftPressed'] = true
	elif rightIsPressed(playerIndex):
		inputs['rightPressed'] = true
	
	if jumpIsPressed(playerIndex):
		inputs['jumpPressed'] = true
	
	if secondaryActionIsPressed(playerIndex):
		inputs['secondaryActionPressed'] = true
		
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

func secondaryActionIsPressed(playerIndex):
	if Input.is_action_pressed("secondaryAction"):
		return true
	if Input.is_joy_button_pressed(playerIndex, secondaryAction1):
		return true
	if Input.is_joy_button_pressed(playerIndex, secondaryAction2):
		return true
	
