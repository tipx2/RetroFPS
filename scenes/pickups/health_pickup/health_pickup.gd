extends Area

var amount;

func _on_health_body_entered(body):
	if body.name == "player" and body.player_health < body.MAX_PLAYER_HEALTH:
		body.damage(-amount)
		queue_free()
