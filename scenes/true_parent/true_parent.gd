extends Node

# https://freesound.org/people/jorickhoofd/sounds/176671/
# https://freesound.org/people/SmartWentCody/sounds/179005/
# https://freesound.org/people/juskiddink/sounds/108617/

var settings = "res://settings.save"
var progression_file = "res://progression.save"

# saved settings
var saved_fps = 240;
var saved_fullscreen = true;

var saved_master_volume = 50;
var saved_music_volume = 25;

var player_fov = 100;
var invert_mouse_y = false;
var invert_mouse_x = false;
var mouse_sens = 0.2;

var crosshair_colour = 0
var crosshair_colour_array = ["red", "white", "black"]
var crosshair_size = 1

var font_type = 0
var font_size = 30
var font_array = ["AlumniSansPinstripe-Regular.ttf", "Lexend-Regular.ttf"]

var progression;
# one bool for each level

var main_menu = load("res://scenes/UI/main_menu/main_menu.tscn")

func _ready():
	# load in the settings variables
	load_settings(settings)
	
	# set settings variables to saved values
	
	# video
	Engine.set_target_fps(saved_fps)
	OS.window_fullscreen = saved_fullscreen
	OS.window_borderless = saved_fullscreen
	OS.window_maximized = !saved_fullscreen
	OS.window_resizable = !saved_fullscreen
	
	# font
	var dyna_font = load("res://assets/UI_assets/fonts/button_font.tres")
	dyna_font.size = font_size
	dyna_font.font_data = load("res://assets/UI_assets/fonts/" + font_array[font_type])
	
	# audio
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(saved_master_volume/100 * 2))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Soundtrack"), linear2db(saved_music_volume/100 * 2))
	
	# load in progression bool array
	load_progression(progression_file)
	
	var menu_instance = main_menu.instance()
	add_child(menu_instance)

func switch_to_scene(scene1name, scene2):
	get_node(scene1name).queue_free()
	var scene2_instance = scene2.instance()
	add_child(scene2_instance)

func save_progression():
	var f = File.new()
	f.open(progression_file, File.WRITE)
	f.store_var(progression)
	f.close()

func load_progression(prog_file):
	var f = File.new()
	f.open(prog_file, File.READ)
	progression = f.get_var()
	f.close()

func load_settings(settings_file):
	var f = File.new()
	f.open(settings_file, File.READ)
	saved_fps = f.get_var()
	saved_fullscreen = f.get_var()
	saved_master_volume = f.get_var()
	saved_music_volume = f.get_var()
	player_fov = f.get_var()
	invert_mouse_x = f.get_var()
	invert_mouse_y = f.get_var()
	mouse_sens = f.get_var()
	font_type = f.get_var()
	font_size = f.get_var()
	crosshair_colour = f.get_var()
	crosshair_size = f.get_var()
	# put all saved settings here
	f.close()
