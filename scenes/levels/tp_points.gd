extends Spatial

func _on_tp_area_body_entered(body):
	if body.name == "skinwalker":
		print("tping")
		body.global_transform.origin = Vector3(0.0, 4.0, 0.0)
