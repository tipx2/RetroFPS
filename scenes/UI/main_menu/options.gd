extends ColorRect

onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]

var settings = "res://settings.save"

func _on_TextureButton_pressed():
	# close the options
	set_visible(false)
	Engine.set_target_fps($"%force_fps_box".value)
	# set the true parent values to be saved
	true_parent.saved_fps = $"%force_fps_box".value
	true_parent.saved_fullscreen = $"%fullscreen_button".pressed
	# save the true_parent settings values to a file
	save_settings(settings)
	

func _ready():
	# set the options buttons to saved values
	$"%force_fps_box".value = true_parent.saved_fps
	$"%fullscreen_button".pressed = true_parent.saved_fullscreen


func _on_fullscreen_button_toggled(button_pressed):
	# toggle the fullscreen properties
	OS.window_fullscreen = button_pressed
	OS.window_borderless = button_pressed
	OS.window_maximized = !button_pressed
	OS.window_resizable = !button_pressed

func save_settings(settings_file):
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(true_parent.saved_fps)
	f.store_var(true_parent.saved_fullscreen)
	# save all settings stored on true_parent here
	f.close()
