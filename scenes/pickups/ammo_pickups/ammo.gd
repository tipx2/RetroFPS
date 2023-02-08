extends Area

var type;
var amount;

func _on_ammo_body_entered(body):
	if body.name == "player":
		# find the weapon according to the given type
		var weapon_number = body.weapon_arr.find(type)
		# don't pick it up if we're at max ammo for that weapon
		if body.ammo_array[weapon_number] < body.max_ammo_array[weapon_number]:
			body.add_ammo(weapon_number, amount)
			queue_free()
