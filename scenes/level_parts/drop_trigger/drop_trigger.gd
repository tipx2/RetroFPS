extends Spatial

var boss
export(NodePath) onready var dropped_platform = get_node_or_null(dropped_platform)
export(String) var drop_direction = "forward"
export(bool) var boss_revealer = false

func _ready():
	boss = get_node_or_null("%big_boss")

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		print("DROPPED")
		dropped_platform.drop(drop_direction)
		queue_free()
		
		if boss and boss_revealer:
			boss.spin(true)
			boss.reveal_bar()
