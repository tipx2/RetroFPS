extends Area

func _on_test_plate_body_entered(body):
	if body.name == "player":
		body.damage(5)
