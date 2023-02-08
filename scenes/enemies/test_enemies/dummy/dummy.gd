extends KinematicBody

onready var mesh_instance = get_node("MeshInstance")
onready var animation_player = get_node("AnimationPlayer")

var direction = Vector3.ZERO
var gravity_vec = Vector3()
var health = 300

func damage(amount):
	animation_player.play("damage")
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()

func _physics_process(delta):
	# force downward if not on floor
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * 2 * delta
	# lerp movement vectors back to 0 if moving (simulate friction)
	direction.x = lerp(direction.x, 0, 0.03)
	direction.z = lerp(direction.z, 0, 0.03)
	# move (every frame)
	direction += gravity_vec
	var _move = move_and_slide(direction, Vector3.UP)
