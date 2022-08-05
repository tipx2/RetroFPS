extends Area

var type;
var amount;

func _on_ammo_body_entered(body):
	if body.name == "player":
		var weapon_number = body.weapon_arr.find(type)
		if body.ammo_array[weapon_number] < body.max_ammo_array[weapon_number]:
			body.add_ammo(weapon_number, amount)
			queue_free()
