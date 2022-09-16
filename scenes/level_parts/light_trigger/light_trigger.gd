extends Spatial

export(NodePath) onready var light = get_node_or_null(light)
export(bool) onready var opener

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		if opener:
			light.turn_on()
		else:
			light.turn_off()
		queue_free()
