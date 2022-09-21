extends TextureRect

onready var timer = get_node("Timer")

func _process(delta):
	rect_position.y = lerp(rect_position.y, 0, 0.6)
	rect_position.x = lerp(rect_position.x, 180, 0.6)
	
func _on_Timer_timeout():
	rect_position.y = lerp(rect_position.y, rect_position.y + rand_range(-40,40), 0.7)
	rect_position.x = lerp(rect_position.x, rect_position.x + rand_range(-40,40), 0.7)
