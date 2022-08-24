extends Spatial

var conditional = true
export(bool) var opener
export(NodePath) onready var gate = get_node_or_null(gate)

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		if conditional:
			if opener:
				gate.open_gate()
			else:
				gate.close_gate()
			queue_free()
