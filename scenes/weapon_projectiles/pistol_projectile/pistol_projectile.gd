extends KinematicBody

var direction
var proj_speed = 20

onready var death_timer = get_node("death_timer")

onready var spark_particles = get_node("spark_particles")
onready var blood_particles = get_node("blood_particles")

onready var collision = get_node("CollisionShape")

var collision_info

func _ready():
	death_timer.start()
	set_as_toplevel(true)

func _physics_process(delta):
	collision_info = move_and_collide(direction.normalized() * proj_speed)
	if collision_info:
		if collision_info.collider.is_in_group("enemies"):
			collision_info.collider.damage(34)
			direction = Vector3.ZERO
			collision.set_disabled(true)
			blood_particles.set_emitting(true)
		else:
			spark_particles.set_emitting(true)

func _on_death_timer_timeout():
	queue_free()

func set_direction(dir):
	direction = dir
