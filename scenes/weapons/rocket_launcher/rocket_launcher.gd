extends "res://scenes/weapons/projectile_weapon.gd"

func _init():
	projectile = load("res://scenes/weapon_projectiles/rocket/rocket.tscn")
	backwards = 1


func set_projectile_direction():
	projectile_instance.set_direction(muzzle.global_transform.basis.z * backwards)
