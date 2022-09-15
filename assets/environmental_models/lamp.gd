extends Spatial

export(float) var seconds

func _ready():
	$Timer.start(seconds)

func _on_Timer_timeout():
	$AnimationPlayer.play("flicker")
