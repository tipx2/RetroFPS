extends Spatial

const SHOTGUN_PROJECTILE = preload("res://scenes/weapon_projectiles/shotgun_projectile/shotgun_projectile.tscn")
var shotgun_instance

onready var muzzle = get_node("muzzle")
onready var animation_player = get_node("AnimationPlayer")

func _ready():
	randomize()

func shoot():
	if Input.is_action_just_pressed("shoot") and !animation_player.is_playing():
		animation_player.play("shoot")
		for _x in range(10):
			add_pellet(-muzzle.global_transform.basis.z)

func add_pellet(dir):
	shotgun_instance = SHOTGUN_PROJECTILE.instance()
	shotgun_instance.set_direction(dir)
	muzzle.add_child(shotgun_instance)
