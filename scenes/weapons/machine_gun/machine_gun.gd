extends "res://scenes/weapons/projectile_weapon.gd"

func _init():
	projectile = load("res://scenes/weapon_projectiles/machine_gun_projectile/machine_gun_projectile.tscn")
	backwards = -1
