extends "res://scenes/level_parts/gate_opener/gate_opener.gd"

export(String, "red", "yellow", "blue") var open_colour
onready var player = get_tree().get_nodes_in_group("player")[0]

func check_for_condition():
	if (open_colour == "red" and player.red_key) or (open_colour == "yellow" and player.yellow_key) or (open_colour == "blue" and player.blue_key):
		return true
	else:
		return false
