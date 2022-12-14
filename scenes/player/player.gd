extends KinematicBody

# true parent
onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]

# cheat detector
onready var cheat_code_detector = get_tree().get_nodes_in_group("cheat_detector")[0]
onready var camera_animator = get_node("head/Camera/camera_animator")
onready var camera = get_node("head/Camera")
var superhot_mode = false

# weapons
onready var pistol = get_node("head/pistol")
onready var shotgun = get_node("head/shotgun")

onready var weapons = get_tree().get_nodes_in_group("weapons")

var weapon_arr = []
var current_weapon = 0

# weapon switching
onready var switch_timer = get_node("switch_timer")

# aiming
var mouse_sens = 0.2
onready var head = $head

var x_flipper = 1
var y_flipper = 1

# crosshair customisation
var cross_colour = 0
var cross_size = 1

# movement
var direction = Vector3()
var speed = 20
var bonus_direction = Vector3.ZERO
var snap = Vector3(0,-0.2,0)

# gravity and jumping
var gravity_force = 2
var jump_force = 1
var gravity_vec = Vector3()
onready var ground_check = $GroundCheck
var grounded

# ammo and health values
const MAX_PLAYER_HEALTH = 100
var player_health = 100
var dying = false
var ammo_array = []

var max_ammo_array = [0, 50, 400, 200, 15]

# UI updating
onready var health_label = get_node("GUI/gameplay_UI/Panel/HBoxContainer/VBoxContainer/health_amount")
onready var health_bar = get_node("GUI/gameplay_UI/Panel/HBoxContainer/VBoxContainer/health_bar")
onready var ammo_label = get_node("GUI/gameplay_UI/Panel/HBoxContainer/ammo_label_container/ammo_amount")
onready var ammo_type_label = get_node("GUI/gameplay_UI/Panel/HBoxContainer/ammo_label_container/ammo_type")

onready var crosshair = get_node("GUI/gameplay_UI/crosshair")

onready var gameplay_UI = get_node("GUI/gameplay_UI")
onready var UI_animation = get_node("GUI/gameplay_UI/UI_animation")

onready var icon_backgrounds = get_tree().get_nodes_in_group("icon_background")

onready var win_screen = get_tree().get_nodes_in_group("win_screen")[0]
onready var death_screen = get_tree().get_nodes_in_group("death_screen")[0]

# keys
var red_key = false
var blue_key = false
var yellow_key = false

onready var key_icons = get_tree().get_nodes_in_group("key_icon")

func _ready():
	camera.set_frustum_offset(Vector2(0,0))
	update_mouse_flippers(true_parent.invert_mouse_x, true_parent.invert_mouse_y)
	update_camera_fov(true_parent.player_fov)
	update_crosshair_colour(true_parent.crosshair_colour)
	update_crosshair_size(true_parent.crosshair_size)
	cheat_code_detector.connect("cheat_detected", self, "_on_cheat_detected")
	for w in weapons:
		weapon_arr.append(w.name)
		ammo_array.append(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if not dying:
		# aiming
		if event is InputEventMouseMotion:
			rotate_y(deg2rad(-event.relative.x * x_flipper * mouse_sens))
			head.rotate_x(deg2rad(-event.relative.y * y_flipper * mouse_sens))
			head.rotation.x = clamp(head.rotation.x, deg2rad(-80), deg2rad(89))
		# weapon scrolling
		elif event is InputEventMouseButton:
			if event.button_index == BUTTON_WHEEL_UP:
				switch_to_weapon(current_weapon - 1)
			if event.button_index == BUTTON_WHEEL_DOWN:
				switch_to_weapon(current_weapon + 1)

func _physics_process(delta):
	direction = Vector3()
	
	grounded = is_on_floor()
	# gravity and jumping
	if grounded:
		gravity_vec = Vector3.ZERO
		snap = -get_floor_normal() * 0.2
	else:
		gravity_vec += Vector3.DOWN * gravity_force * delta
		snap = Vector3.ZERO
	
	if Input.is_action_just_pressed("jump") and grounded:
		gravity_vec = Vector3.UP * jump_force
	
	# movement
	if not dying:
		direction += -transform.basis.x * (Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
		direction += -transform.basis.z * (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	
	# weapon switching
	if Input.is_action_just_pressed("swap_to_fists"):
		switch_to_weapon(0)
	if Input.is_action_just_pressed("swap_to_pistol"):
		switch_to_weapon(1)
	if Input.is_action_just_pressed("swap_to_shotgun"):
		switch_to_weapon(2)
	if Input.is_action_just_pressed("swap_to_machine_gun"):
		switch_to_weapon(3)
	if Input.is_action_just_pressed("swap_to_rocket_launcher"):
		switch_to_weapon(4)
		
	# pause game
	if Input.is_action_just_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().get_nodes_in_group("pause_menu")[0].set_visible(true)
		get_tree().paused = true
	
	# shooting
	for w in weapons:
		if w.is_visible():
			w.shoot()
	
	bonus_direction = bonus_direction.linear_interpolate(Vector3.ZERO, 0.1)
	
	direction = direction.normalized()
	
	direction += gravity_vec
	direction += bonus_direction
	
	var _move = move_and_slide_with_snap(direction * speed, snap, Vector3.UP)
	
	if superhot_mode:
		if direction.round() == Vector3.ZERO or direction.round() == Vector3(0,-1,0):
			Engine.time_scale = 0.02
		else:
			Engine.time_scale = 1

func update_mouse_flippers(x, y):
	x_flipper = (-1 if x else 1)
	y_flipper = (-1 if y else 1)

func update_camera_fov(fov):
	camera.size = fov/1000

func update_mouse_sens(sens):
	mouse_sens = sens/100.0

func update_crosshair_colour(colour):
	var selected_hex : String
	match colour:
		0:
			selected_hex = "#ba0f0f"
		1:
			selected_hex = "#ffffff"
		2:
			selected_hex = "#000000"
		3:
			selected_hex = "#DAA520"
		4:
			selected_hex = "#b8860b"
	crosshair.self_modulate = Color(selected_hex)

func update_crosshair_size(size):
	crosshair.rect_scale = Vector2(size, size)

func update_hud_health():
	health_label.text = str(player_health)
	health_bar.value = player_health

func update_hud_ammo():
	if weapon_arr[current_weapon] == "fists":
		ammo_label.text = "Infinite"
	else:
		ammo_label.text = str(ammo_array[current_weapon])
	ammo_type_label.text = weapon_arr[current_weapon].capitalize()

func damage(amount):
	if amount < 0: # runs if player heals
		gameplay_UI.get_health(amount)
	else: # runs if player takes damage 
		$"%hurt_noise".play()
		$"%gameplay_UI".splatter_blood(amount * 2)
	player_health -= amount
	if MAX_PLAYER_HEALTH < player_health:
		player_health = MAX_PLAYER_HEALTH
	elif player_health <= 0:
		die()
	update_hud_health()

func add_ammo(weapon_num, amount):
	if amount > 0:
		gameplay_UI.get_ammo(weapon_arr[weapon_num])
	ammo_array[weapon_num] += amount
	if ammo_array[weapon_num] > max_ammo_array[weapon_num]:
		ammo_array[weapon_num] = max_ammo_array[weapon_num]
	update_hud_ammo()

func switch_to_weapon(weapon):
	if switch_timer.get_time_left() == 0:
		switch_timer.start()
		
		# account for scrolling wraparound
		if weapon > len(weapon_arr)-1:
			weapon = 0
		elif weapon < 0:
			weapon = len(weapon_arr)-1
		current_weapon = weapon
		
		# set all weapons invisible
		for w in weapons:
			w.visible = false
		
		# make only the current weapon visible
		var get_current_weapon = get_node("head/" + weapon_arr[current_weapon])
		get_current_weapon .visible = true
		get_current_weapon.animation_player.play("switch_in")
		
		# set all icon backgrounds to the same colour
		for back in icon_backgrounds:
			back.set_self_modulate(Color("ffffff"))
			
		# make only the current weapon icon background green
		icon_backgrounds[current_weapon].set_self_modulate(Color("00ff46"))
		update_hud_ammo()

func give_key(colour):
	$"%key_noise".play()
	match colour:
		"red":
			red_key = true
		"blue":
			blue_key = true
		"yellow":
			yellow_key = true
	var colour_array = ["#db0d0d", "#1c4ad4", "#eddb11"]
	var key_array = [red_key, blue_key, yellow_key]
	for x in range(3):
		if key_array[x]:
			key_icons[x].color = Color(colour_array[x])

func win():
	get_tree().paused = true
	win_screen.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func die():
	dying = true
	camera_animator.play("die")

func display_death_screen():
	get_tree().paused = true
	death_screen.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_cheat_detected(cheat):
	if cheat == "pfa": # power full ammo
		for x in range(len(max_ammo_array)):
			ammo_array[x] = max_ammo_array[x]
			update_hud_ammo()
	elif cheat == "psh": # power super hot
		superhot_mode = !superhot_mode
		Engine.time_scale = 1
	elif cheat == "phm": # power headache mode
		if camera_animator.is_playing():
			camera_animator.stop()
			camera.set_frustum_offset(Vector2(0,0))
		else:
			camera_animator.play("headache_mode")
	elif cheat == "pfk":
		give_key("red")
		give_key("yellow")
		give_key("blue")
