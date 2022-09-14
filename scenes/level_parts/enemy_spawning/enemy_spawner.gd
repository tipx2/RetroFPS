extends Node

export(int) var number

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		for spawn_point in get_tree().get_nodes_in_group("spawn_" + str(number)):
			spawn_point.spawn_enemy()
			yield(get_tree().create_timer(0.1), "timeout")
		$Area/CollisionShape.disabled = true
