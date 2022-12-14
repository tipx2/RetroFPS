extends Spatial

var main_menu = load("res://scenes/UI/main_menu/main_menu.tscn")

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var level_name = get_tree().get_nodes_in_group("level_parent")[0]
onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]

export(int) var level

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		true_parent.progression[level] = true
		true_parent.save_progression()
		player.win()
