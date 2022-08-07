extends KinematicBody

# cheat detector
onready var cheat_code_detector = get_tree().get_nodes_in_group("cheat_detector")[0]
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

# movement
var direction = Vector3()
var speed = 20

# gravity and jumping
var gravity_force = 2
var jump_force = 1
var gravity_vec = Vector3()
onready var ground_check = $GroundCheck

# ammo and health values
const MAX_PLAYER_HEALTH = 60
var player_health = 60
var ammo_array = []

var max_ammo_array = [0, 50, 400, 200, 15]

# UI updating
onready var health_label = get_node("GUI/gameplay_UI/Panel/HBoxContainer/VBoxContainer/health_amount")
onready var ammo_label = get_node("GUI/gameplay_UI/Panel/HBoxContainer/VBoxContainer2/ammo_amount")
onready var ammo_type_label = get_node("GUI/gameplay_UI/Panel/HBoxContainer/VBoxContainer2/ammo_type")

onready var pickup_popup = get_node("GUI/gameplay_UI/pickup_popup")
onready var UI_animation = get_node("GUI/gameplay_UI/UI_animation")

onready var icon_backgrounds = get_tree().get_nodes_in_group("icon_background")

func _ready():
	cheat_code_detector.connect("cheat_detected", self, "_on_cheat_detected")
	for w in weapons:
		weapon_arr.append(w.name)
		ammo_array.append(0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# aiming
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
	# weapon scrolling
	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			switch_to_weapon(current_weapon - 1)
		if event.button_index == BUTTON_WHEEL_DOWN:
			switch_to_weapon(current_weapon + 1)

func _physics_process(delta):
	direction = Vector3()
	
	var grounded = ground_check.is_colliding()
	
	# gravity and jumping
	if !grounded:
		gravity_vec += Vector3.DOWN * gravity_force * delta
		
	if Input.is_action_just_pressed("jump") and grounded:
		gravity_vec = Vector3.UP * jump_force
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	# movement
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
		
	# shooting
	for w in weapons:
		if w.is_visible():
			w.shoot()
	
	direction = direction.normalized()
	direction += gravity_vec
	var _move = move_and_slide(direction * speed, Vector3.UP)
	
	if superhot_mode:
		if direction.round() == Vector3.ZERO or direction.round() == Vector3(0,-1,0):
			Engine.time_scale = 0.02
		else:
			Engine.time_scale = 1

func update_hud_health():
	health_label.text = str(player_health)

func update_hud_ammo():
	if weapon_arr[current_weapon] == "fists":
		ammo_label.text = "Infinite"
	else:
		ammo_label.text = str(ammo_array[current_weapon])
	ammo_type_label.text = weapon_arr[current_weapon].capitalize()

func damage(amount):
	if amount < 0:
		pickup_popup.text = "You just healed for " + str(amount * -1) + " health"
		if UI_animation.is_playing():
			UI_animation.stop()
		UI_animation.play("pickup_popup_fade")
	player_health -= amount
	if MAX_PLAYER_HEALTH < player_health:
		player_health = MAX_PLAYER_HEALTH
	update_hud_health()

func add_ammo(weapon_num, amount):
	if amount > 0:
		pickup_popup.text = "You just picked up " + weapon_arr[weapon_num].capitalize() + " ammo"
		if UI_animation.is_playing():
			UI_animation.stop()
		UI_animation.play("pickup_popup_fade")
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

func _on_cheat_detected(cheat):
	if cheat == "pfa":
		for x in range(len(max_ammo_array)):
			ammo_array[x] = max_ammo_array[x]
			update_hud_ammo()
	if cheat == "psh":
		superhot_mode = !superhot_mode
