extends "res://scenes/enemies/base_enemy.gd"

func _init():
	speed = 28
	update_time = 0.1
	gravity_force = 20
	optimise_pathfinding = false # if false, the enemy will move more sporadically
	attacking_range = 10
	health = 300
	
	projectile = load("res://scenes/enemy_projectiles/exsanguinist_projectile/exsanguinist_projectile.tscn")
