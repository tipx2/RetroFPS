extends ColorRect

onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]

var settings = "res://settings.save"

func _on_TextureButton_pressed():
	# close the options
	set_visible(false)
	Engine.set_target_fps($"%force_fps_box".value)
	# set the true parent values to be saved
	# video
	true_parent.saved_fps = $"%force_fps_box".value
	true_parent.saved_fullscreen = $"%fullscreen_button".pressed
	
	# audio
	true_parent.saved_master_volume = $"%master_volume_slider".value
	true_parent.saved_music_volume = $"%music_volume_slider".value
	
	# gameplay
	true_parent.invert_mouse_x = $"%invert_mouse_x".pressed
	true_parent.invert_mouse_y = $"%invert_mouse_y".pressed
	true_parent.player_fov = $"%player_fov".value
	true_parent.mouse_sens = $"%sens_slider".value
	
	var player_arr = get_tree().get_nodes_in_group("player")
	if player_arr.size() == 1:
		player_arr[0].update_mouse_flippers(true_parent.invert_mouse_x, true_parent.invert_mouse_y)
		player_arr[0].update_camera_fov(true_parent.player_fov)
		player_arr[0].update_mouse_sens(true_parent.mouse_sens)
	# save the true_parent settings values to a file
	save_settings(settings)

func _ready():
	# set the options buttons to saved values
	$"%force_fps_box".value = true_parent.saved_fps
	$"%fullscreen_button".pressed = true_parent.saved_fullscreen
	$"%master_volume_slider".value = true_parent.saved_master_volume
	$"%music_volume_slider".value = true_parent.saved_music_volume
	$"%invert_mouse_x".pressed = true_parent.invert_mouse_x
	$"%invert_mouse_y".pressed = true_parent.invert_mouse_y
	$"%player_fov".value = true_parent.player_fov
	$"%sens_slider".value = true_parent.mouse_sens

func _on_fullscreen_button_toggled(button_pressed):
	# toggle the fullscreen properties
	OS.window_fullscreen = button_pressed
	OS.window_borderless = button_pressed
	OS.window_maximized = !button_pressed
	OS.window_resizable = !button_pressed

func _on_master_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value/100 * 2))

func _on_music_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Soundtrack"), linear2db(value/100 * 2))


func fill_saves_with(boo):
	for value in range(len(true_parent.progression)):
		true_parent.progression[value] = boo
	true_parent.save_progression()

func _on_delete_my_save_pressed():
	fill_saves_with(false)
	$"are_you_sure".visible = false

func _on_full_save_pressed():
	fill_saves_with(true)

func _on_clear_save_pressed():
	$"are_you_sure".visible = true

func _on_dont_delete_my_save_pressed():
	$"are_you_sure".visible = false


func save_settings(settings_file):
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(true_parent.saved_fps)
	f.store_var(true_parent.saved_fullscreen)
	f.store_var(true_parent.saved_master_volume)
	f.store_var(true_parent.saved_music_volume)
	f.store_var(true_parent.player_fov)
	f.store_var(true_parent.invert_mouse_x)
	f.store_var(true_parent.invert_mouse_y)
	f.store_var(true_parent.mouse_sens)
	
	# save all settings stored on true_parent here
	f.close()
