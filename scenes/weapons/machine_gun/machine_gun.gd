extends Spatial

const MACHINE_PROJECTILE = preload("res://scenes/weapon_projectiles/machine_gun_projectile/machine_gun_projectile.tscn")
var machine_instance

onready var muzzle = get_node("muzzle")
onready var animation_player = get_node("AnimationPlayer")

func shoot():
	if Input.is_action_pressed("shoot") and !animation_player.is_playing():
		animation_player.play("shoot")
		machine_instance = MACHINE_PROJECTILE.instance()
		machine_instance.set_direction(-muzzle.global_transform.basis.x)
		muzzle.add_child(machine_instance)
