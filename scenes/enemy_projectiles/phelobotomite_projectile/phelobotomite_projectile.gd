extends "res://scenes/enemy_projectiles/enemy_projectile.gd"

var spread = 0.5

func _init():
	speed = rand_range(50, 75)
	damage = 1
	expiry_time = rand_range(0.1, 0.3)
	hitbox_radius = 1.5


func set_target(target, muzzle):
	direction = muzzle.global_transform.origin.direction_to(target.global_transform.origin)
	direction.x += rand_range(-spread,spread)
	direction.z += rand_range(-spread,spread)
