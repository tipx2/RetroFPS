extends "res://scenes/weapons/projectile_weapon.gd"

func _init():
	projectile = load("res://scenes/weapon_projectiles/shotgun_projectile/shotgun_projectile.tscn")
	backwards = 1

func _ready():
	randomize()

func fire_projectile():
	for _x in range(10):
		add_pellet(-muzzle.global_transform.basis.z)

func add_pellet(dir):
	projectile_instance = projectile.instance()
	projectile_instance.set_direction(dir)
	muzzle.add_child(projectile_instance)
