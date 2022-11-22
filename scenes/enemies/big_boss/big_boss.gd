extends KinematicBody

enum{
	IDLE
	STAGE_ONE
	STAGE_TWO
	DEATH
}
var state = IDLE

func _process(delta):
	match state:
		IDLE:
			pass
		STAGE_ONE:
			pass
		STAGE_TWO:
			pass
		DEATH:
			pass

var health = 0

func damage(amount):
	health -= amount
