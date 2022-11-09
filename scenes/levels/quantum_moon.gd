extends MeshInstance

onready var quantum_positions = get_tree().get_nodes_in_group("quantum_pos")


func _ready():
	go_to_position(quantum_positions[randi() % quantum_positions.size()].transform.origin)


func _on_VisibilityNotifier_camera_exited(camera):
	quantum_positions.shuffle()
	for pos in quantum_positions:
		if !pos.get_node("VisibilityNotifier").is_on_screen() and pos.is_inside_tree():
			go_to_position(pos.global_transform.origin)
			break


func go_to_position(pos):
	global_transform.origin = pos
