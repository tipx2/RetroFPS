extends MeshInstance

var past_three_positions = []

onready var quantum_positions = get_tree().get_nodes_in_group("quantum_pos")
onready var player = get_tree().get_nodes_in_group("player")[0]


func _ready():
	var first_position = quantum_positions[randi() % quantum_positions.size()]
	go_to_position(first_position.transform.origin)
	append_pos(first_position)

func _on_VisibilityNotifier_screen_exited():
	print("left screen")
	quantum_positions.shuffle()
	for pos in quantum_positions:
		if !pos.get_node("VisibilityNotifier").is_on_screen()  and pos.name != past_three_positions[-1] and pos.is_inside_tree():
			go_to_position(pos.global_transform.origin)
			append_pos(pos)
			break

func append_pos(pos):
	past_three_positions.append(pos.name)
	if len(past_three_positions) == 4:
		past_three_positions.pop_front()
	
	if past_three_positions == ["Position_1", "Position_2", "Position_3"]:
		puzzle_solved()


func go_to_position(pos):
	print("teleported")
	global_transform.origin = pos

func puzzle_solved():
	print("Solved that dang ol puzzle matey")
	player.tp_to_eye()
