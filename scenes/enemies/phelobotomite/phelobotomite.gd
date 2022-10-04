extends "res://scenes/enemies/base_enemy.gd"

func _init():
	speed = 20
	update_time = 0.2
	gravity_force = 20
	optimise_pathfinding = true # if false, the enemy will move more sporadically
	attacking_range = 30
	health = 200
	
	projectile = load("res://scenes/enemy_projectiles/phelobotomite_projectile/phelobotomite_projectile.tscn")

func spawn_projectile():
	for _x in range(3):
		var projectile_instance = projectile.instance()
		get_tree().get_root().add_child(projectile_instance)
		projectile_instance.set_target(player, muzzle)
		projectile_instance.global_transform.origin = muzzle.global_transform.origin
