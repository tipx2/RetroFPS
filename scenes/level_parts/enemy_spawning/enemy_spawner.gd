extends Node

export(int) var number

export(bool) var gateopener = false
export(NodePath) var gate

func _ready():
	gate = get_node_or_null(gate)

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		for spawn_point in get_tree().get_nodes_in_group("spawn_" + str(number)):
			spawn_point.spawn_enemy()
			yield(get_tree().create_timer(0.1), "timeout")
		$Area/CollisionShape.disabled = true
		if gateopener:
			$check_for_death.start()


func _on_check_for_death_timeout():
	var enemies = get_tree().get_nodes_in_group("spawn_" + str(number) + "_wave")
	if (not enemies):
		gate.open_gate()
		queue_free()
