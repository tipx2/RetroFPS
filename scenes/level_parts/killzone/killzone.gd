extends Area

func _on_killzone_body_entered(body):
	if body.name == "player":
		body.die()
	else:
		body.queue_free()
