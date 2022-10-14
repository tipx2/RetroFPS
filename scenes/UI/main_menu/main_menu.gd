extends Control

onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]

var settings = "res://settings.save"

func _on_play_button_pressed():
	$"%level_select".update_buttons()
	$"%level_select".set_visible(true)

func _on_options_button_pressed():
	$"%options".set_visible(true)

func _on_quit_button_pressed():
	get_tree().quit()

func _on_tutorial_button_pressed():
	true_parent.switch_to_scene("main_menu", load("res://scenes/levels/tutorial.tscn"))
