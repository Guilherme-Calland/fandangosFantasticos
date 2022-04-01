extends StaticBody2D

var numberGenerator
var inAttackArea = false

func _ready():
	$AnimationPlayer.play("sleeping")
	numberGenerator = RandomNumberGenerator.new()

func _on_AttackArea_body_entered(body):
	inAttackArea = true
	attack()

func _on_AttackArea_body_exited(body):
	inAttackArea = false
	$AnimationPlayer.queue("idle")

func _on_SightArea_body_entered(body):
	$AnimationPlayer.play("wakingUp")

func _on_SightArea_body_exited(body):
	$AnimationPlayer.play_backwards("wakingUp")

func attack():
	if inAttackArea:
		numberGenerator.randomize()
		var attackNum = numberGenerator.randi_range(0,1)
		var attackType
		if attackNum == 0:
			attackType = "areaAttack"
		elif attackNum == 1:
			attackType = "stingAttack"
		if $AnimationPlayer.current_animation == "idle":
			$AnimationPlayer.play(attackType)
		else:
			$AnimationPlayer.queue(attackType)
