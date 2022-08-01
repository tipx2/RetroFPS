extends KinematicBody

var direction
var proj_speed = 5
onready var death_timer = get_node("death_timer")

var collision_info

func _ready():
	set_as_toplevel(true)
	death_timer.start()

func _physics_process(delta):
	collision_info = move_and_collide(direction * proj_speed)
	if collision_info:
		queue_free()

func _on_death_timer_timeout():
	queue_free()
