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
