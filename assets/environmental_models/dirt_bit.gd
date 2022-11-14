extends Spatial

func drop(dir):
	$AnimationPlayer.play("drop_" + dir)
