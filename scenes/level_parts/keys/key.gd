extends Spatial

export(String, "red", "blue", "yellow") var colour

func _ready():
	$AnimatedSprite3D.animation = colour + "_key"


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		body.give_key(colour)
		queue_free()
