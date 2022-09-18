extends Spatial

export(NodePath) onready var soundtrack_off = get_node_or_null(soundtrack_off)

export(NodePath) onready var soundtrack_on = get_node_or_null(soundtrack_on)


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		toggle_sounds()

func toggle_sounds():
	if soundtrack_off.is_playing() and !soundtrack_on.is_playing():
		soundtrack_off.playing = false
		soundtrack_on.playing = true
		queue_free()
