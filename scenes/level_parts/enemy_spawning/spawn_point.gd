extends Position3D

export(String) var spawn_path

onready var enemy = load(spawn_path)

func spawn_enemy():
	var enemy_instance = enemy.instance()
	add_child(enemy_instance)
