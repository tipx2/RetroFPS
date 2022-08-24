extends Spatial

onready var animation_player = get_node("AnimationPlayer")

func open_gate():
	animation_player.play("open")

func close_gate():
	animation_player.play("close")
