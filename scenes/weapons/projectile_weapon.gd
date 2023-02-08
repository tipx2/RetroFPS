extends Spatial

var projectile;
var projectile_instance;
var ammo_amount = 1

onready var player = get_parent().get_parent()

onready var muzzle = get_tree().get_nodes_in_group("muzzle")[0]
onready var animation_player = get_node("AnimationPlayer")
onready var sound_effect = get_node_or_null("AudioStreamPlayer")

func shoot():
	# check if we aren't already shooting
	if Input.is_action_pressed("shoot") and !animation_player.is_playing():
		if player.ammo_array[player.weapon_arr.find(name)] > 0:
			player.add_ammo(player.weapon_arr.find(name), -ammo_amount)
			# play sound effect if the player exists
			if sound_effect:
				sound_effect.set_pitch_scale(rand_range(0.95, 1.3))
			animation_player.play("shoot")
			fire_projectile()
		else:
			# play ammo empty
			pass

func fire_projectile():
	# instantiate and set the direction of the projectile we're firing
	projectile_instance = projectile.instance()
	projectile_instance.global_transform = muzzle.global_transform
	set_projectile_direction()
	get_tree().get_root().add_child(projectile_instance)

func set_projectile_direction():
	projectile_instance.set_direction(muzzle.global_transform.basis.x)
