class_name IndicatorRound
extends Node3D

@onready var mesh_instance: MeshInstance3D = $"indicator-round-d/rotate-y"

func set_indicator_material(material: StandardMaterial3D):
	mesh_instance.mesh.surface_set_material(0, material)

func set_indicator_scale(scale_value: float):
	mesh_instance.scale = Vector3(scale_value, scale_value, scale_value)
