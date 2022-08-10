extends Node

var proto_world = load("res://scenes/proto_world/proto_world.tscn")

func _ready():
	var instance_world = proto_world.instance()
	add_child(instance_world)
