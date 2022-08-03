extends Area

func _on_killzone_body_entered(body):
	if body.name == "player":
		get_tree().quit()
	else:
		body.queue_free()
