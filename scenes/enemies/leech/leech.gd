extends "res://scenes/enemies/base_enemy.gd"

# Constants
const BASE_ATTACK_DASH_SPEED = 70 # Base speed for attacking dash

# Variables
var attack_dash_speed = 70 # Speed for attacking dash
var damage = 10 # Amount of damage the enemy deals to the player

var attacking_arr = [] # Array to store attacking objects
var attack_dir # Direction of the attack
var damaged # Flag to check if the player has been damaged during the attack

# Nodes
onready var attack_timer = get_node("attack_timer") # Timer for controlling the attack duration
onready var attack_area = get_node("mesh/attack_area") # Area of effect for the attack

func _init():
	# Initialize base variables from the base enemy script
	speed = 25
	update_time = 0.2
	gravity_force = 20
	optimise_pathfinding = true # Optimize pathfinding for more efficient movement
	attacking_range = 7
	health = 230
	
	look_on_update = true # Enable looking at the player while updating the path

# Function for attacking
func attacking(_collision_object):
	# Check if the attack timer is not running
	if attack_timer.is_stopped():
		# Play the "drawback" animation
		animation_player.play("drawback")
		# Get the direction to the player
		attack_dir = global_transform.origin.direction_to(player.global_transform.origin)
		damaged = false
		# Set the Y component to 0 to ignore vertical movement
		attack_dir.y = 0
		# Start the attack timer
		attack_timer.start()
	# Check if the player hasn't been damaged and the animation is not playing
	if !damaged and !animation_player.is_playing():
		# Check for overlapping bodies in the attack area
		for body in attack_area.get_overlapping_bodies():
			# Check if the overlapping body is in the "player" group
			if body.is_in_group("player"):
				damaged = true
				# Deal damage to the player
				body.damage(damage)
	# Move in the attack direction with the dash speed
	var _move = move_and_slide(attack_dir * attack_dash_speed)

# Function for handling the timeout of the attack timer
func _on_attack_timer_timeout():
	# Change the state to CHASING
	state = CHASING

# Function to set attack dash speed to 0
func speed_zero():
	attack_dash_speed = 0

# Function to return attack dash speed to base value
func speed_return():
	# Interpolate the attack dash speed from the base value to 0 with a smooth transition
	attack_dash_speed = lerp(BASE_ATTACK_DASH_SPEED, 0, 0.2)
