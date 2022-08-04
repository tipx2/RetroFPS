extends "res://scenes/weapon_projectiles/projectile.gd"

onready var explosion_area = get_node("explosion_area")
onready var explosion_particles = get_node("explosion")
onready var rocket_mesh = get_node("rocket_mesh")

func _init():
	rng.randomize()
	proj_speed = 1
	spread = 0
	damage = 0
	time = 1

func hit_enemies():
	particles_emitted = true
	explosion_particles.set_emitting(true)
	rocket_mesh.set_visible(false)
	for body in explosion_area.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			var direction = body.global_transform.origin - global_transform.origin
			var distance = direction.length()
			direction = direction.normalized()
			var velocity = direction * distance * 20
			body.damage(10000 * (1/(distance + 100)) +3)
			velocity.y = 0
			body.direction += velocity

func check_for_hit():
	hit_enemies()

func stop_emitting():
	if particles_emitted and !explosion_particles.is_emitting():
		queue_free()

func _on_death_timer_timeout():
	hit_enemies()
