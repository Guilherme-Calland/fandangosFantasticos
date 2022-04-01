extends StaticBody2D

func _ready():
	$AnimationPlayer.play("sleeping")

func _on_AttackArea_body_entered(body):
	$AnimationPlayer.play("areaAttack")

func _on_AttackArea_body_exited(body):
	$AnimationPlayer.play("idle")

func _on_SightArea_body_entered(body):
	$AnimationPlayer.play("wakingUp")

func _on_SightArea_body_exited(body):
	$AnimationPlayer.play("backToSleep")
