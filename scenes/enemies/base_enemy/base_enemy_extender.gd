extends "res://scenes/enemies/base_enemy.gd"

func _init():
	speed = 20
	update_time = 0.2
	gravity_force = 20
	optimise_pathfinding = true # if false, the enemy will move more sporadically
	attacking_range = 20
	health = 200
