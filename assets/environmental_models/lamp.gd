extends Spatial

export(float) var seconds

func _ready():
	yield(get_tree().create_timer(seconds), "timeout")
	$AnimationPlayer.play("flicker")
