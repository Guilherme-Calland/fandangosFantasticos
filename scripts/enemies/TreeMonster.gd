extends StaticBody2D

func _ready():
	$AnimationPlayer.play("idle")

func playReady():
	$AnimationPlayer.play("ready")

func playIdle():
	$AnimationPlayer.play("idle")

func playAreaAttack():
	$AnimationPlayer.play("areaAttack")

func playReady2():
	$AnimationPlayer.play("ready2")


func _on_Area2D_body_entered(body):
	print('collision')
	if not $AnimationPlayer.current_animation == "ready" && not $AnimationPlayer.current_animation == "ready2":
			$AnimationPlayer.play("gettingReady")

func _on_Area2D_body_exited(body):
	if not $AnimationPlayer.current_animation == "idle":
			$AnimationPlayer.play("backToIdle")
