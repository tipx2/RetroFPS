extends "res://scenes/weapon_projectiles/projectile.gd"

onready var explosion_area = get_node("explosion_area")
onready var rocket_mesh = get_node("rocket_mesh")

onready var explosive_mesh = get_node("explosive_mesh")
onready var explosion_player = get_node("explosion_player")

func _init():
	rng.randomize()
	proj_speed = 2
	spread = 0
	damage = 0
	time = 1

func hit_enemies():
	direction = Vector3.ZERO
	particles_emitted = true
	explosive_mesh.set_visible(true)
	explosive_mesh.rotation_degrees = Vector3(rand_range(0,360), rand_range(0,360), rand_range(0,360))
	rocket_mesh.set_visible(false)
	explosion_player.play("explode")
	for body in explosion_area.get_overlapping_bodies():
		if body.is_in_group("enemies") or body.is_in_group("player"):
			var direction = body.global_transform.origin - global_transform.origin
			var distance = direction.length()
			direction = direction.normalized()
			var velocity = direction * 3
			if body.is_in_group("enemies"):
				body.damage(round(10000 * (1/(distance + 50)) +3), body.global_transform.origin)
			elif body.is_in_group("player"):
				velocity.y *= 0.25
				body.damage(5)
			body.bonus_direction += velocity

func check_for_hit():
	hit_enemies()

func stop_emitting():
	if particles_emitted and !explosion_player.is_playing():
		queue_free()

func _on_death_timer_timeout():
	hit_enemies()
