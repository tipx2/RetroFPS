extends Control

onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]

var game = load("res://scenes/proto_world/proto_world.tscn")

onready var soundtrack = get_node("Soundtrack")
onready var musicFade = get_node("musicFade")

func _ready():
	# retrieve and set the options here
	soundtrack.play()
	musicFade.play("fadeIn")

func _on_play_button_pressed():
	$"%level_select".set_visible(true)

func _on_options_button_pressed():
	$"%options".set_visible(true)

func _on_quit_button_pressed():
	get_tree().quit()
