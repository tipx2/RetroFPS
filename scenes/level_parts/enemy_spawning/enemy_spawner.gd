extends Node

export(int) var number

export(bool) var gateopener = false
export(NodePath) var gate

func _ready():
	gate = get_node_or_null(gate)

func _on_Area_body_entered(body):
	# Check if the entered body is the player
	if body.is_in_group("player"):
		# Spawn enemies from spawn points with the specified wave number
		for spawn_point in get_tree().get_nodes_in_group("spawn_" + str(number)):
			spawn_point.spawn_enemy()
			# Wait 0.1 seconds before proceeding
			yield(get_tree().create_timer(0.1), "timeout")
		# Disable the CollisionShape after the enemies have been spawned
		$Area/CollisionShape.disabled = true
		# If the gateopener variable is set to true, start checking for enemy death
		if gateopener:
			$check_for_death.start()

# This function runs when the check_for_death timer times out
func _on_check_for_death_timeout():
	# Get all the enemies in the wave with the specified number
	var enemies = get_tree().get_nodes_in_group("spawn_" + str(number) + "_wave")
	# If there are no more enemies, open the gate and remove this script
	if (not enemies):
		gate.open_gate()
		queue_free()
