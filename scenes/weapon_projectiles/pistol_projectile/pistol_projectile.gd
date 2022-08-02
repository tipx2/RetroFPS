extends KinematicBody

var direction
var proj_speed = 20
onready var death_timer = get_node("death_timer")

var collision_info

func _ready():
	set_as_toplevel(true)
	death_timer.start()

func _physics_process(delta):
	collision_info = move_and_collide(direction.normalized() * proj_speed)
	if collision_info:
		if collision_info.collider.is_in_group("enemies"):
			collision_info.collider.damage(34)
		queue_free()

func _on_death_timer_timeout():
	queue_free()

func set_direction(dir):
	direction = dir
