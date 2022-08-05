extends Spatial

var projectile;
var projectile_instance;
var backwards = 1

onready var player = get_parent().get_parent()

onready var muzzle = get_node("muzzle")
onready var animation_player = get_node("AnimationPlayer")


func shoot():
	if Input.is_action_pressed("shoot") and !animation_player.is_playing():
		if player.ammo_array[player.weapon_arr.find(name)] > 0:
			player.add_ammo(player.weapon_arr.find(name), -1)
			animation_player.play("shoot")
			fire_projectile()
		else:
			# play ammo empty
			pass

func fire_projectile():
	projectile_instance = projectile.instance()
	projectile_instance.set_direction(muzzle.global_transform.basis.x * backwards)
	projectile_instance.set_as_toplevel(true)
	muzzle.add_child(projectile_instance)
