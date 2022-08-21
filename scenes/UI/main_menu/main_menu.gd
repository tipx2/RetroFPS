extends Control

onready var soundtrack = get_node("Soundtrack")
onready var musicFade = get_node("musicFade")

func _ready():
	soundtrack.play()
	musicFade.play("fadeIn")
