extends "res://scenes/enemies/base_enemy.gd"

var attack_dash_speed = 50
var damage = 10


var attacking_arr = [];
var attack_dir;
var damaged;
onready var attack_timer = get_node("attack_timer")
onready var attack_area = get_node("mesh/attack_area")

func _init():
	speed = 25
	update_time = 0.2
	gravity_force = 20
	optimise_pathfinding = true # if false, the enemy will move more sporadically
	attacking_range = 20
	health = 230
	
	look_on_update = true

func attacking(collision_object):
	if attack_timer.is_stopped():
		if !animation_player.is_playing():
			animation_player.play("drawback")
		attack_dir = global_transform.origin.direction_to(player.global_transform.origin)
		damaged = false
		attack_dir.y = 0
		attack_timer.start()
	if !damaged:
		for body in attack_area.get_overlapping_bodies():
			if body.is_in_group("player"):
				damaged = true
				body.damage(damage)
	move_and_slide(attack_dir * lerp(attack_dash_speed, 0, 0.2))

func _on_attack_timer_timeout():
	state = CHASING
