extends Node

var main_menu = load("res://scenes/UI/main_menu/main_menu.tscn")

func _ready():
	var menu_instance = main_menu.instance()
	add_child(menu_instance)

func music_fade_into(scene1, scene2):
	scene1.get_node_or_null("musicFade").play("fadeOut")
	scene2.get_node_or_null("musicFade").play("fadeIn")
