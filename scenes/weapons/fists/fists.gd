extends Spatial

onready var animation_player = get_node("AnimationPlayer")
onready var hitbox = get_node("hitbox")

var fist = "right"


func shoot():
	if Input.is_action_pressed("shoot") and !animation_player.is_playing():
		animation_player.play(fist + "_hook")
		for body in hitbox.get_overlapping_bodies():
			if body.is_in_group("enemies"):
				body.damage(25)
		if fist == "right":
			fist = "left"
		else:
			fist = "right"
