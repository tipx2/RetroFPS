extends "res://scenes/enemies/base_enemy.gd"

const BASE_ATTACK_DASH_SPEED = 70
var attack_dash_speed = 70
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
	attacking_range = 7
	health = 230
	
	look_on_update = true

func attacking(_collision_object):
	if attack_timer.is_stopped():
		animation_player.play("drawback")
		attack_dir = global_transform.origin.direction_to(player.global_transform.origin)
		damaged = false
		attack_dir.y = 0
		attack_timer.start()
	if !damaged and !animation_player.is_playing():
		for body in attack_area.get_overlapping_bodies():
			if body.is_in_group("player"):
				damaged = true
				body.damage(damage)
	var _move = move_and_slide(attack_dir * attack_dash_speed)

func _on_attack_timer_timeout():
	state = CHASING

func speed_zero():
	attack_dash_speed = 0

func speed_return():
	attack_dash_speed = lerp(BASE_ATTACK_DASH_SPEED, 0, 0.2)
