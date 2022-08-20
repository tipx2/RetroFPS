extends Spatial

onready var animation_player = get_node("AnimationPlayer")
onready var hitbox = get_node("hitbox")

var fist = "right"
var damage = 25
onready var space_state = get_world().get_direct_space_state()

func shoot():
	if Input.is_action_pressed("shoot") and !animation_player.is_playing():
		animation_player.play(fist + "_hook")
		for body in hitbox.get_overlapping_bodies():
			if body.is_in_group("enemies"):
				var result = space_state.intersect_ray(global_transform.origin, body.global_transform.origin)
				if result:
					body.damage(damage, result.position)
				else:
					body.damage(damage, body.global_transform.origin)
		if fist == "right":
			fist = "left"
		else:
			fist = "right"
