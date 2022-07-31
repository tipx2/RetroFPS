extends Node

var player = load("res://scenes/player/player.tscn")
var proto_world = load("res://scenes/proto_world/proto_world.tscn")

func _ready():
	var player_instance = player.instance()
	var instance_world = proto_world.instance()
	instance_world.add_child(player_instance)
	add_child(instance_world)
	get_node("proto").get_node("player").global_transform.origin = get_node("proto").get_node("playerPosition").global_transform.origin
