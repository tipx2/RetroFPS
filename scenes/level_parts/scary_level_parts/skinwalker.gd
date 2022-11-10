extends KinematicBody

var playing_funny_noise = true
var translator_up = false

onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]
onready var head = get_node("head")
onready var gun_cam = get_node("CanvasLayer/ViewportContainer/Viewport/Camera2")

onready var mouse_sens = true_parent.mouse_sens/100.0

var main_menu = load("res://scenes/UI/main_menu/main_menu.tscn")
var direction = Vector3.ZERO
var speed = 10

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Timer.wait_time = rand_range(1, 10)
	$Timer.start()


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x) * mouse_sens)
		head.rotate_x(deg2rad(-event.relative.y) * mouse_sens)
		head.rotation.x = clamp(head.rotation.x, deg2rad(-80), deg2rad(89))

func _process(delta):
	gun_cam.global_transform = $head/Camera.global_transform
	var coll = $head/script_reader.get_collider()
	if coll and coll.is_in_group("nomai_writings") and !translator_up:
		translator_up = true
		$head/translator/Label3D.text = coll.text
		$AnimationPlayer.play("tranlator_appear")
	elif !coll and translator_up:
		translator_up = false
		$AnimationPlayer.play("tranlator_disappear")
		

func _physics_process(delta):
	direction = Vector3.ZERO
	direction += -transform.basis.x * (Input.get_action_strength("move_left") - Input.get_action_strength("move_right"))
	direction += -transform.basis.z * (Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward"))
	var _velocity = move_and_slide(direction.normalized() * speed)
	
	if Input.is_action_just_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().get_nodes_in_group("scary_pause_menu")[0].set_visible(true)
		get_tree().paused = true


func _on_Resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().get_nodes_in_group("scary_pause_menu")[0].set_visible(false)
	get_tree().paused = false

func _on_menu_pressed():
	get_tree().paused = false
	if get_tree().get_nodes_in_group("level_parent").size() > 1:
		print("you have loaded multiple scenes at once")
		get_tree().quit()
	true_parent.switch_to_scene(get_tree().get_nodes_in_group("level_parent")[0].name, main_menu)

func tp_to_eye():
	$"%teleparticles".emitting = true
	global_transform.origin = get_tree().get_nodes_in_group("player_eye_point")[0].global_transform.origin


func _on_Timer_timeout():
	if playing_funny_noise:
		$AudioStreamPlayer3D.pitch_scale = rand_range(0.1, 1.5)
		$AudioStreamPlayer3D.play()
		$Timer.wait_time = rand_range(5, 10)
		$Timer.start()
