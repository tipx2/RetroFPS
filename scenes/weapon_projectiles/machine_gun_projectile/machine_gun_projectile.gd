extends KinematicBody

var direction
var proj_speed = 10

var spread = 0.02

onready var death_timer = get_node("death_timer")

var collision_info

func _ready():
	visible = false
	set_as_toplevel(true)
	death_timer.start()

func _physics_process(delta):
	collision_info = move_and_collide(direction.normalized() * proj_speed)
	if collision_info:
		if collision_info.collider.is_in_group("enemies"):
			collision_info.collider.damage(7)
		queue_free()

func _on_death_timer_timeout():
	queue_free()

func set_direction(dir):
	dir.x += rand_range(-spread, spread)
	dir.y += rand_range(-spread, spread)
	direction = dir


func _on_visible_timer_timeout():
	visible = true
