extends "res://scenes/weapon_projectiles/projectile.gd"

func _init():
	rng.randomize()
	proj_speed = 6
	spread = 0.11
	damage = 11
	time = 5
