extends KinematicBody

onready var mesh_instance = get_node("MeshInstance")
onready var animation_player = get_node("AnimationPlayer")

var health = 100

func damage(amount):
	animation_player.play("damage")
	health -= amount
	if health <= 0:
		die()

func die():
	queue_free()
