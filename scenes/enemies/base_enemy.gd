extends KinematicBody

# overriding variables
var speed;
var update_time;
var gravity_force;
var optimise_pathfinding;# if disabled, the enemy will move more sporadically
var attacking_range;
var health;
var look_on_update = false;

# state machine
enum{
	LOOKING,
	CHASING,
	ATTACKING,
	DYING
}
var state = LOOKING

# looking
onready var looking_cast = get_node("looking_cast")
onready var mesh = get_node("mesh")

# damage
var blood_particles = load("res://scenes/particles/blood_particles.tscn")
onready var health_label = get_node("health_amount")

# shooting
var projectile;
onready var muzzle = $"%muzzle"

# animation
onready var animation_player = get_node("AnimationPlayer")

# movement
var bonus_direction = Vector3.ZERO
var direction = Vector3.ZERO
var safe_direction = Vector3.ZERO

# pathfinding
var path : PoolVector3Array
var path_index = 0

onready var nav_agent = get_node("NavigationAgent")
onready var navigation = get_tree().get_nodes_in_group("nav")[0]
onready var update_timer = get_node("Timer")

# reference to player
onready var player = get_tree().get_nodes_in_group("player")[0]
var weak_ref_player;

func _ready():
	weak_ref_player = weakref(player)
	$"healthbar_sprite".get_node("Viewport/healthbar").max_value = health
	$"healthbar_sprite".get_node("Viewport/healthbar").value = health
	update_timer.set_wait_time(update_time)
	update_timer.start()

func _process(_delta):
	var collision_object = looking_cast.get_collider()
	match state:
		LOOKING:
			looking(collision_object)
		CHASING:
			chasing(collision_object)
		ATTACKING:
			attacking(collision_object)
		DYING:
			dying()
	looking_cast.set_cast_to(global_transform.origin.direction_to(player.global_transform.origin) * 100)

func _physics_process(delta):
	direction = Vector3.ZERO
	if state == CHASING:
		if path.size() > path_index:
			direction = global_transform.origin.direction_to(path[path_index]).normalized()
			if global_transform.origin.distance_to(path[path_index]) < 2:
				path_index += 1
	if not is_on_floor():
		direction += Vector3.DOWN * gravity_force * delta
	bonus_direction = bonus_direction.linear_interpolate(Vector3.ZERO, 0.05)
	direction += bonus_direction
	
	nav_agent.set_velocity(direction)
	var _move = move_and_slide(safe_direction * speed)

func damage(amount, collision_point):
	health -= amount
	if health <= 0:
		state = DYING
	health_label.text = str(health)
	$"healthbar_sprite".get_node("Viewport/healthbar").value = health
	var blood_instance = blood_particles.instance()
	blood_instance.set_emitting(true)
	add_child(blood_instance)
	blood_instance.look_at_from_position(collision_point, player.global_transform.origin, Vector3.UP)
	blood_instance.rotate(Vector3.UP, PI)

# states
func looking(collision_object):
	if collision_object and collision_object.is_in_group("player"):
		state = CHASING

func chasing(collision_object):
	# note that the pathfinding for chasing takes place in _physics_process
	if global_transform.origin.distance_to(player.global_transform.origin) <= attacking_range and (collision_object and collision_object.is_in_group("player")):
		state = ATTACKING

func dying():
	animation_player.play("die")

func attacking(collision_object):
	if !animation_player.is_playing():
		
		look_at_player()
		
		# play the shooting animation
		animation_player.play("shoot")
		
		spawn_projectile()
		
	if global_transform.origin.distance_to(player.global_transform.origin) >= attacking_range or (collision_object and !collision_object.is_in_group("player")):
		state = CHASING

func spawn_projectile():
	# spawn the projectile
	var projectile_instance = projectile.instance()
	get_tree().get_root().add_child(projectile_instance)
	projectile_instance.set_target(player, muzzle)
	projectile_instance.global_transform.origin = muzzle.global_transform.origin

func look_at_player():
	if weak_ref_player.get_ref():
		var player_pos = player.global_transform.origin
		player_pos.y = global_transform.origin.y
		mesh.look_at(player_pos, Vector3.UP)
		if look_on_update:
			$CollisionShape.look_at(player_pos, Vector3.UP)

func _on_Timer_timeout():
	if weak_ref_player.get_ref():
		var player_pos = player.global_transform.origin
		path = NavigationServer.map_get_path(RID(navigation), global_transform.origin,
			player_pos, optimise_pathfinding, 1)
		path_index = 1
		if look_on_update and state != ATTACKING:
			look_at_player()
		draw_path(path)

#debug
func draw_path(path_array):
	if len(path_array) == 0:
		print("No path")
		return
	var im = get_tree().get_nodes_in_group("draw")[0]
	im.clear()
	im.begin(Mesh.PRIMITIVE_POINTS, null)
	im.add_vertex(path_array[0])
	im.add_vertex(path_array[path_array.size() - 1])
	im.end()
	im.begin(Mesh.PRIMITIVE_LINE_STRIP, null)
	for x in path:
		im.add_vertex(x)
	im.end()


func _on_NavigationAgent_velocity_computed(safe_velocity):
	safe_direction = safe_velocity


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		queue_free()
