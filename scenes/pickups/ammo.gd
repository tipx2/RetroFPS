extends Area

var type;
var amount;

func _on_ammo_body_entered(body):
	if body.name == "player":
		body.add_ammo(type, amount)
		queue_free()
