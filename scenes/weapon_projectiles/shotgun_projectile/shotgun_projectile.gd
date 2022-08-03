extends "res://scenes/weapon_projectiles/projectile.gd"

func _init():
	rng.randomize()
	proj_speed = 6
	spread = 0.12
	damage = 10
	time = 5
