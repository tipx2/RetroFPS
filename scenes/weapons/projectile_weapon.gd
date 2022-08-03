extends Spatial

var projectile;
var projectile_instance;
var backwards = 1;

onready var muzzle = get_node("muzzle")
onready var animation_player = get_node("AnimationPlayer")

func shoot():
	if Input.is_action_pressed("shoot") and !animation_player.is_playing():
		animation_player.play("shoot")
		projectile_instance = projectile.instance()
		projectile_instance.set_direction(muzzle.global_transform.basis.x * backwards)
		muzzle.add_child(projectile_instance)
