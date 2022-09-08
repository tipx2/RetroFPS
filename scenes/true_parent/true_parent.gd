extends Node

var settings = "res://settings.save"

var saved_fps;
var saved_fullscreen;

var saved_master_volume;
var saved_music_volume = 50

var progression = [false,false, false, false, false] # etc 
# one bool for each level

var main_menu = load("res://scenes/UI/main_menu/main_menu.tscn")


func _ready():
	load_settings(settings)
	print(saved_master_volume)
	# set variables to saved values
	# video
	Engine.set_target_fps(saved_fps)
	OS.window_fullscreen = saved_fullscreen
	OS.window_borderless = saved_fullscreen
	OS.window_maximized = !saved_fullscreen
	OS.window_resizable = !saved_fullscreen
	
	# audio
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(saved_master_volume/100 * 2))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Soundtrack"), linear2db(saved_music_volume/100 * 2))
	
	var menu_instance = main_menu.instance()
	add_child(menu_instance)

func switch_to_scene(scene1name, scene2):
	get_node(scene1name).queue_free()
	var scene2_instance = scene2.instance()
	add_child(scene2_instance)

func load_settings(settings_file):
	var f = File.new()
	f.open(settings_file, File.READ)
	saved_fps = f.get_var()
	saved_fullscreen = f.get_var()
	saved_master_volume = f.get_var()
	saved_music_volume = f.get_var()
	# put all saved settings here
	f.close()
