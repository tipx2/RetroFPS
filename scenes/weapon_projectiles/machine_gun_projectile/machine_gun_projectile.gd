extends "res://scenes/weapon_projectiles/projectile.gd"

func _init():
	rng.randomize()
	proj_speed = 40
	spread = 0.05
	damage = 9
	time = 5
