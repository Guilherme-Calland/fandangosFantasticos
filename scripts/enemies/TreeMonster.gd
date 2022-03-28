extends StaticBody2D

func _ready():
	$AnimationPlayer.play("idle")

func run():
	if $RayCast2D.is_colliding() || $RayCast2D2.is_colliding() || $RayCast2D3.is_colliding():
		if not $AnimationPlayer.current_animation == "ready":
			$AnimationPlayer.play("gettingReady")
	elif not $RayCast2D.is_colliding():
		if not $AnimationPlayer.current_animation == "idle":
			$AnimationPlayer.play("backToIdle")

func playReady():
	$AnimationPlayer.play("ready")

func playIdle():
	$AnimationPlayer.play("idle")
