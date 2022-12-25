extends KinematicBody

onready var true_parent = get_tree().get_nodes_in_group("true_parent")[0]
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var shotpoints = get_tree().get_nodes_in_group("shoot_point")
var MAX_HEALTH = 5000
var health = 5000
var bonus_direction = Vector3() # for ignoring rocket launcher vel boost

enum{
	STAGE_ONE
	STAGE_TWO
	DEATH
}
var state = STAGE_ONE

func _ready():
	$CanvasLayer/TextureProgress.max_value = MAX_HEALTH
	$CanvasLayer/TextureProgress.value = MAX_HEALTH
	
func _process(delta):
	match state:
		STAGE_ONE:
			pass
		STAGE_TWO:
			pass
		DEATH:
			pass


func damage(amount, second_thing):
	health -= amount
	$CanvasLayer/TextureProgress.value = health
	if health <= 0:
		state = DEATH
		spin(false)
		$shot_timer.paused = true
		$AnimationPlayer.play("die")
		$CollisionShape.disabled = true
		
		$die_timer.start()
	elif state == STAGE_ONE and health <= (MAX_HEALTH/2):
		go_to_stage_two()

func spin(boo):
	get_parent().rotating = boo
	$shot_timer.start()

func reveal_bar():
	get_node("CanvasLayer/AnimationPlayer").play("bar_reveal")

func go_to_stage_two():
	get_parent().spin_multiplier = 2
	$shot_timer.wait_time = 1
	$AudioStreamPlayer.play()
	state = STAGE_TWO


func _on_shot_timer_timeout():
	shotpoints[randi() % shotpoints.size()].fire()


func _on_die_timer_timeout():
	true_parent.progression[3] = true
	true_parent.save_progression()
	player.win()
