extends Control

onready var blood_holder = $"%blood_holder"
var blood_splatter = preload("res://scenes/UI/gameplay_UI/blood_splatter.tscn")

func splatter_blood(amount):
	for _x in range(amount):
		var blood_decal = blood_splatter.instance()
		blood_holder.add_child(blood_decal)
		blood_decal.global_transform.origin.y = rand_range(0,1080)
		blood_decal.global_transform.origin.x = rand_range(0,1920)
		blood_decal.rotation_degrees = rand_range(0,360)
