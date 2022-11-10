extends StaticBody

export(String, MULTILINE) var text

func _on_VisibilityNotifier_camera_exited(camera):
	rotation_degrees = Vector3(0,rand_range(0, 360), 0)
