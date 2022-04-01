extends StaticBody2D

func _ready():
	$AnimationPlayer.play("idle")

func playReady():
	$AnimationPlayer.play("ready")

func playIdle():
	$AnimationPlayer.play("idle")

func playAreaAttack():
	$AnimationPlayer.play("areaAttack")

func _on_Area2D_body_entered(body):
#	if not $AnimationPlayer.current_animation == "ready":
#			$AnimationPlayer.play("gettingReady")
	playAreaAttack()

func _on_Area2D_body_exited(body):
	if not $AnimationPlayer.current_animation == "idle":
			$AnimationPlayer.play("backToIdle")
