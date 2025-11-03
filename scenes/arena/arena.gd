class_name Arena
extends Node3D

@onready var indicator_round: IndicatorRound = $IndicatorRound

func update_indicator(pos: Vector3, scale_value: float = 1, material: StandardMaterial3D = null):
	indicator_round.show()
	indicator_round.set_indicator_scale(scale_value)
	indicator_round.global_position = pos
	if material != null:
		indicator_round.set_indicator_material(material)

func hide_indicator():
	indicator_round.hide()
	
