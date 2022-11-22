extends Spatial

var rotating = true

func _physics_process(delta):
	if rotating:
		rotate_y(0.01)
