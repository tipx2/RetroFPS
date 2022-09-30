extends Spatial

var materials = [load("res://assets/materials/houses/house.tres"), load("res://assets/materials/houses/house2.tres"), load("res://assets/materials/houses/house3.tres")]

# Called when the node enters the scene tree for the first time.
func _ready():
	var pick = materials[randi() % materials.size()]
	$MeshInstance.set_surface_material(0, pick)
