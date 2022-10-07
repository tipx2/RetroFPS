extends StaticBody

onready var animation_player = get_node("AnimationPlayer")

var bonus_direction = Vector3()

func damage(a, b):
	for spawn_point in get_tree().get_nodes_in_group("spawn_1"):
		spawn_point.spawn_enemy()
