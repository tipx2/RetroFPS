extends KinematicBody

var direction
var proj_speed = 6
onready var death_timer = get_node("death_timer")

var xspread = 0.1
var yspread = 0.1

var collision_info

func _ready():
	randomize()
	set_as_toplevel(true)
	death_timer.start()

func _physics_process(delta):
	collision_info = move_and_collide(direction.normalized() * proj_speed)
	if collision_info:
		queue_free()

func _on_death_timer_timeout():
	queue_free()

func set_direction(dir):
	dir.x += rand_range(-xspread, xspread)
	dir.y += rand_range(-yspread, yspread)
	direction = dir
