extends Control

onready var blood_holder = $"%blood_holder"
onready var pickup_popup = $"pickup_popup"
onready var UI_animation = $"UI_animation"
onready var popup_anim = $"popup_anim"

var blood_splatter = preload("res://scenes/UI/gameplay_UI/blood_splatter.tscn")

func splatter_blood(amount):
	for _x in range(amount):
		var blood_decal = blood_splatter.instance()
		blood_holder.add_child(blood_decal)
		blood_decal.global_transform.origin.y = rand_range(0,1080)
		blood_decal.global_transform.origin.x = rand_range(0,1920)
		blood_decal.rotation_degrees = rand_range(0,360)

func get_ammo(type):
	pickup_popup.text = "You just picked up " + type.capitalize() + " ammo"
	stop_run_anim()
	UI_animation.play("reset")
	UI_animation.queue(type + "_ammo_get")

func get_health(amount):
	pickup_popup.text = "You just healed for " + str(amount * -1) + " health"
	stop_run_anim()

func stop_run_anim():
	if popup_anim.is_playing():
		popup_anim.stop()
	popup_anim.play("pickup_popup_fade")
