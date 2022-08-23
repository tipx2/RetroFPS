extends ColorRect

var main_menu = load("res://scenes/UI/main_menu/main_menu.tscn")
onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]

func _on_resume_button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	get_tree().get_nodes_in_group("pause_menu")[0].set_visible(false)

func _on_options_button_pressed():
	$"%options".set_visible(true)

func _on_menu_button_pressed():
	unpause()
	if get_tree().get_nodes_in_group("level_parent").size() > 1:
		print("you have loaded multiple scenes at once")
		get_tree().quit()
	true_parent.switch_to_scene(get_tree().get_nodes_in_group("level_parent")[0].name, main_menu)

func unpause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = false
