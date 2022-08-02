extends Node

var player = load("res://scenes/player/player.tscn")
var proto_world = load("res://scenes/proto_world/proto_world.tscn")
var dummy = load("res://scenes/enemies/dummy/dummy.tscn")

func _ready():
	var player_instance = player.instance()
	var instance_world = proto_world.instance()
	instance_world.add_child(player_instance)
	add_child(instance_world)
	get_node("proto").get_node("player").global_transform.origin = get_node("proto").get_node("playerPosition").global_transform.origin
	for dummypos in get_tree().get_nodes_in_group("dummy_pos"):
		create_dummy(dummypos.global_transform)

func create_dummy(pos):
	var dummy_instance = dummy.instance()
	dummy_instance.set_global_transform(pos)
	add_child(dummy_instance)
