extends ColorRect

onready var main_menu = get_tree().get_nodes_in_group("main_menu")[0]
onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]
onready var cheat_code_detector = get_tree().get_nodes_in_group("cheat_detector")[0]

onready var level_buttons = get_tree().get_nodes_in_group("level_buttons")
var level_button_names = []

var proto_world = load("res://scenes/proto_world/proto_world.tscn")

# IMPORTANT: this must be in the order that the buttons are
var levels = [load("res://scenes/levels/level_one.tscn")]

func _ready():
	cheat_code_detector.connect("cheat_detected", self, "_on_cheat_detected")
	for button in level_buttons:
		button.connect("pressed", self, "_some_button_pressed", [button])
		level_button_names.append(button.name)
		
		var completed = true_parent.progression[level_buttons.find(button)]
		button.get_node("VBoxContainer/CenterContainer4/HBoxContainer/ColorRect/cross_rect").visible = !completed
		button.get_node("VBoxContainer/CenterContainer4/HBoxContainer/ColorRect/tick_rect").visible = completed


func _some_button_pressed(button):
	var level_index = level_button_names.find(button.name)
	
	if level_index > levels.size() - 1 or level_index == -1:
		print("level not present in level array")
		return
	
	true_parent.switch_to_scene("main_menu", levels[level_index])
	print("switching to " + button.name)

func _on_LevelTextureButton_pressed():
	$"%level_select".set_visible(false)


func _on_cheat_detected(cheat):
	if cheat == "dpw": # debug proto world
		true_parent.switch_to_scene("main_menu", proto_world)
