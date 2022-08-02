extends KinematicBody

var direction
var proj_speed = 6

onready var death_timer = get_node("death_timer")

onready var spark_particles = get_node("spark_particles")
onready var blood_particles = get_node("blood_particles")

onready var collision = get_node("CollisionShape")

var xspread = 0.1
var yspread = 0.1

var collision_info

func _ready():
	death_timer.start()
	randomize()
	set_as_toplevel(true)

func _physics_process(delta):
	collision_info = move_and_collide(direction.normalized() * proj_speed)
	if collision_info:
		if collision_info.collider.is_in_group("enemies"):
			collision_info.collider.damage(10)
			collision.set_disabled(true)
			direction = Vector3.ZERO
			blood_particles.set_emitting(true)
		else:
			spark_particles.set_emitting(true)

func _on_death_timer_timeout():
	queue_free()


func set_direction(dir):
	dir.x += rand_range(-xspread, xspread)
	dir.y += rand_range(-yspread, yspread)
	direction = dir
