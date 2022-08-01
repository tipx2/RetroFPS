extends KinematicBody

# weapons
onready var pistol = get_node("head/pistol")
onready var shotgun = get_node("head/shotgun")

onready var weapons = get_tree().get_nodes_in_group("weapons")

# aiming
var mouse_sens = 0.2
onready var head = $head

# movement
var direction = Vector3()
var speed = 30

# gravity and jumping
var gravity_force = 2
var jump_force = 1
var gravity_vec = Vector3()
onready var ground_check = $GroundCheck

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# aiming
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))

func _physics_process(delta):
	direction = Vector3()
	
	var grounded = ground_check.is_colliding()
	
	# gravity and jumping
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * gravity_force * delta
	elif grounded and is_on_floor():
		gravity_vec = -get_floor_normal() * gravity_force
	else:
		gravity_vec = -get_floor_normal()
		
	if Input.is_action_just_pressed("jump") and (is_on_floor() or grounded):
		gravity_vec = Vector3.UP * jump_force
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	# movement
	direction += -transform.basis.x * (Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	direction += -transform.basis.z * (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	
	# weapon switching
	if Input.is_action_just_pressed("swap_to_pistol"):
		switch_to_weapon(pistol)
	if Input.is_action_just_pressed("swap_to_shotgun"):
		switch_to_weapon(shotgun)
		
	# shooting
	for w in weapons:
		if w.is_visible():
			w.shoot()
	
	direction = direction.normalized()
	direction += gravity_vec
	move_and_slide(direction * speed, Vector3.UP)


func switch_to_weapon(weapon):
	for w in weapons:
		w.visible = false
	weapon.visible = true
