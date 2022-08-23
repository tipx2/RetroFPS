extends Node

var main_menu = load("res://scenes/UI/main_menu/main_menu.tscn")

func _ready():
	var menu_instance = main_menu.instance()
	add_child(menu_instance)

func switch_to_scene(scene1name, scene2):
	var scene2_instance = scene2.instance()
	add_child(scene2_instance)
	get_node(scene1name).queue_free()

func music_fade_into(scene1, scene2):
	scene1.get_node_or_null("musicFade").play("fadeOut")
	scene2.get_node_or_null("musicFade").play("fadeIn")
