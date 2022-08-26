extends ColorRect

onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]
var main_menu = load("res://scenes/UI/main_menu/main_menu.tscn")

func _on_menu_button_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if get_tree().get_nodes_in_group("level_parent").size() > 1:
		print("you have loaded multiple scenes at once")
		get_tree().quit()
	true_parent.switch_to_scene(get_tree().get_nodes_in_group("level_parent")[0].name, main_menu)
