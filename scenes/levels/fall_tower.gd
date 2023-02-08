extends Spatial

func drop(_dir):
	$AnimationPlayer.play("drop_forward")
