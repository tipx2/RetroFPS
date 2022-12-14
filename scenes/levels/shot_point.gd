extends Position3D

onready var player = get_tree().get_nodes_in_group("player")[0]
var projectile = load("res://scenes/enemy_projectiles/boss_projectile/boss_projectile.tscn")

func fire():
	spawn_projectile()

func spawn_projectile():
	# spawn the projectile
	var projectile_instance = projectile.instance()
	get_tree().get_root().add_child(projectile_instance)
	projectile_instance.set_target(player, self)
	projectile_instance.global_transform.origin = global_transform.origin
