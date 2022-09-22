extends Spatial

export(float) var seconds

func _ready():
	$AudioStreamPlayer3D.play()
	$Timer.start(seconds)

func _on_Timer_timeout():
	$AnimationPlayer.play("flicker")
