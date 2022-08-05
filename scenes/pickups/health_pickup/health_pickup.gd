extends Area

var amount;

func _on_health_body_entered(body):
	if body.name == "player" and body.player_health < 60:
		body.damage(-amount)
		queue_free()
