extends KinematicBody

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
			if health <= (MAX_HEALTH/2):
				go_to_stage_two()
		STAGE_TWO:
			pass
		DEATH:
			pass


func damage(amount, second_thing):
	health -= amount
	$CanvasLayer/TextureProgress.value = health
	

func spin(boo):
	get_parent().rotating = boo

func reveal_bar():
	get_node("CanvasLayer/AnimationPlayer").play("bar_reveal")

func go_to_stage_two():
	get_parent().spin_multiplier = 2
	$AudioStreamPlayer.play()
	state = STAGE_TWO
