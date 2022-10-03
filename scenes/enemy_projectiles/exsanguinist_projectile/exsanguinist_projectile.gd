extends "res://scenes/enemy_projectiles/enemy_projectile.gd"

var spread = 0.1

func _init():
	speed = 30
	damage = 3
	expiry_time = 0.25
	hitbox_radius = 2

func set_target(target, muzzle):
	direction = muzzle.global_transform.origin.direction_to(target.global_transform.origin)
	direction.x += rand_range(-spread,spread)
	direction.z += rand_range(-spread,spread)
