extends Spatial

export(Material) var gate_material
onready var animation_player = get_node("AnimationPlayer")

func _ready():
	$MeshInstance.set_surface_material(0, gate_material)

func open_gate():
	animation_player.play("open")

func close_gate():
	animation_player.play("close")
