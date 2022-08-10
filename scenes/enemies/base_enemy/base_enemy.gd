extends KinematicBody

var speed = 20
var update_time = 0.2

var bonus_direction = Vector3.ZERO
var direction = Vector3.ZERO
var path : PoolVector3Array
var path_index = 0

onready var player = get_tree().get_nodes_in_group("player")[0]

onready var nav_agent = get_node("NavigationAgent")
onready var navigation = get_tree().get_nodes_in_group("nav")[0]

onready var update_timer = get_node("Timer")

func _ready():
	update_timer.set_wait_time(update_time)
	update_timer.start()

func _physics_process(delta):
	direction = Vector3.ZERO
	if path.size() > path_index:
		direction = global_transform.origin.direction_to(path[path_index]).normalized()
		if global_transform.origin.distance_to(path[path_index]) < 2:
			path_index += 1
	if not is_on_floor():
		direction += Vector3.DOWN * 20 * delta
	bonus_direction = bonus_direction.linear_interpolate(Vector3.ZERO, 0.05)
	direction += bonus_direction
	
	move_and_slide(direction * speed)

func damage(amount):
	pass

# connected
func _on_Timer_timeout():
	var player_pos = player.global_transform.origin
	path = NavigationServer.map_get_path(RID(navigation), global_transform.origin,
		player_pos, true, 1)
	path_index = 1
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
