extends Spatial

export(bool) var opener
export(NodePath) onready var gate = get_node_or_null(gate)

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		if check_for_condition():
			if opener:
				gate.open_gate()
			else:
				gate.close_gate()
			queue_free()

func check_for_condition():
	return true
