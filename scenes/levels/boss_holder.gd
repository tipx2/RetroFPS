extends Spatial

var rotating = false
var spin_multiplier = 1

func _physics_process(delta):
	if rotating:
		rotate_y(0.01 * spin_multiplier)
