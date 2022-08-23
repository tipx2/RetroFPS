extends KinematicBody

var speed;
var damage;
var expiry_time;
var hitbox_radius;

var direction = Vector3.ZERO
onready var death_timer = get_node("death_timer")
onready var hitcast = get_node("hitcast")
onready var player = get_tree().get_nodes_in_group("player")[0]


func _ready():
	death_timer.set_wait_time(expiry_time)

func _physics_process(_delta):
	hitcast.set_cast_to(global_transform.origin.direction_to(player.global_transform.origin) * hitbox_radius)
	var collision_object = hitcast.get_collider()
	
	if collision_object and collision_object.is_in_group("player"):
		collision_object.damage(damage)
		queue_free()
	
	var _move = move_and_slide(direction * speed)

func set_target(target, muzzle):
	direction = muzzle.global_transform.origin.direction_to(target.global_transform.origin)

func _on_death_timer_timeout():
	queue_free()
