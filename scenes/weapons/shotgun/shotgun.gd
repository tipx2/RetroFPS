extends "res://scenes/weapons/projectile_weapon.gd"

func _init():
	projectile = load("res://scenes/weapon_projectiles/shotgun_projectile/shotgun_projectile.tscn")
	ammo_amount = 10

func _ready():
	randomize()

func fire_projectile():
	for _x in range(10):
		# shoot 10 projectiles with overridden add_pellet function
		add_pellet(muzzle.global_transform.basis.x)

func add_pellet(dir):
	# projectile instatiating and direction setting
	projectile_instance = projectile.instance()
	projectile_instance.set_direction(dir)
	muzzle.add_child(projectile_instance)
