extends Area

var amount;

func _on_health_body_entered(body):
	# if the player is in the body, and is lower than max health
	if body.name == "player" and body.player_health < body.MAX_PLAYER_HEALTH:
		# healing is just negative damage
		body.damage(-amount)
		queue_free()
