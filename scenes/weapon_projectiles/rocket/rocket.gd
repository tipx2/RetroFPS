extends "res://scenes/weapon_projectiles/projectile.gd"

onready var explosion_area = get_node("explosion_area")
onready var explosion_particles = get_node("explosion")
onready var rocket_mesh = get_node("rocket_mesh")

func _init():
	rng.randomize()
	proj_speed = 2
	spread = 0
	damage = 0
	time = 1

func hit_enemies():
	particles_emitted = true
	explosion_particles.set_emitting(true)
	rocket_mesh.set_visible(false)
	for body in explosion_area.get_overlapping_bodies():
		if body.is_in_group("enemies") or body.is_in_group("player"):
			var direction = body.global_transform.origin - global_transform.origin
			var distance = direction.length()
			direction = direction.normalized()
			var velocity = direction * 3
			if body.is_in_group("enemies"):
				body.damage(10000 * (1/(distance + 50)) +3)
			elif body.is_in_group("player"):
				velocity.y *= 1.5
				body.damage(10)
			body.bonus_direction += velocity
			

func check_for_hit():
	hit_enemies()

func stop_emitting():
	if particles_emitted and !explosion_particles.is_emitting():
		queue_free()

func _on_death_timer_timeout():
	hit_enemies()
