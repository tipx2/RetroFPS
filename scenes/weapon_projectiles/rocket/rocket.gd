extends "res://scenes/weapon_projectiles/projectile.gd"

onready var explosion_area = get_node("explosion_area")

func _init():
	rng.randomize()
	proj_speed = 1
	spread = 0
	damage = 0
	time = 10

func check_for_hit():
	for body in explosion_area.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			var direction = body.global_transform.origin - global_transform.origin
			var distance = direction.length()
			direction = direction.normalized()
			var velocity = direction * (100/pow(distance,2))
			body.damage(10000 * (1/(distance + 100)) +3)
			body.direction += velocity
	queue_free()

func stop_emitting():
	pass
