extends KinematicBody

var direction
var proj_speed;
var spread;
var damage;
var time;

var rng = RandomNumberGenerator.new()

onready var death_timer = get_node("death_timer")

onready var spark_particles = get_node_or_null("spark_particles")
onready var blood_particles = get_node_or_null("blood_particles")

onready var collision = get_node("CollisionShape")

var particles_emitted = false
var collision_info

func _ready():
	rng.randomize()
	death_timer.start(time)
	set_as_toplevel(true)

func _physics_process(delta):
	collision_info = move_and_collide(direction.normalized() * proj_speed)
	if collision_info:
		collision.set_disabled(true)
		direction = Vector3.ZERO
		check_for_hit()
		particles_emitted = true
	stop_emitting()

func _on_death_timer_timeout():
	queue_free()

func check_for_hit():
	if collision_info.collider.is_in_group("enemies"):
		collision_info.collider.damage(damage)
		blood_particles.set_emitting(true)
	else:
		spark_particles.set_emitting(true)

func stop_emitting():
	if particles_emitted and !spark_particles.is_emitting() and !blood_particles.is_emitting():
		queue_free()

func set_direction(dir):
	dir.z += rand_range(-spread, spread)
	dir.y += rand_range(-spread, spread)
	dir.x += rand_range(-spread, spread)
	direction = dir
