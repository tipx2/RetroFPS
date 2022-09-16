extends Position3D

export(String) var spawn_path

onready var enemy = load(spawn_path)

func spawn_enemy():
	var enemy_instance = enemy.instance()
	$Particles.emitting = true
	yield(get_tree().create_timer(0.1), "timeout")
	$AudioStreamPlayer3D.play(0.2)
	get_parent().get_parent().add_child(enemy_instance)
	enemy_instance.add_to_group(get_groups()[0] + "_wave") # spawn_n_wave
	enemy_instance.global_transform.origin = global_transform.origin
