extends Spatial

const PISTOL_PROJECTILE = preload("res://scenes/weapon_projectiles/pistol_projectile/pistol_projectile.tscn")
var pistol_instance

onready var muzzle = get_node("muzzle")
onready var animation_player = get_node("AnimationPlayer")

func shoot():
	if Input.is_action_pressed("shoot") and !animation_player.is_playing():
		animation_player.play("shoot")
		pistol_instance = PISTOL_PROJECTILE.instance()
		pistol_instance.direction = muzzle.global_transform.basis.x
		muzzle.add_child(pistol_instance)
