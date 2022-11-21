extends ColorRect

onready var main_menu = get_tree().get_nodes_in_group("main_menu")[0]
onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]
onready var cheat_code_detector = get_tree().get_nodes_in_group("cheat_detector")[0]

var level_buttons;

var proto_world = load("res://scenes/proto_world/proto_world.tscn")

# IMPORTANT: this must be in the order that the buttons are
var levels = [load("res://scenes/levels/level_one.tscn"), load("res://scenes/levels/level_two.tscn"), load("res://scenes/levels/level_three.tscn"), load("res://scenes/levels/level_four.tscn")]

func _ready():
	var level_button = load("res://scenes/UI/main_menu/level_button.tscn")
	for x in range(len(levels)):
		var new_level = level_button.instance()
		$"%LevelGridContainer".add_child(new_level)
		new_level.number_self(x)
	level_buttons = get_tree().get_nodes_in_group("level_buttons")
	cheat_code_detector.connect("cheat_detected", self, "_on_cheat_detected")
	for button in level_buttons:
		button.connect("pressed", self, "_some_button_pressed", [button])

func update_buttons():
	for button in level_buttons:
		var completed = true_parent.progression[level_buttons.find(button)]
		if completed:
			button.self_modulate = Color("08ff00")
		else:
			button.self_modulate = Color("ffffff")


func _some_button_pressed(button):
	var level_index = button.level
	
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
