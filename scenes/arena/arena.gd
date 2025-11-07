class_name Arena
extends Node3D

@onready var indicator_round: IndicatorRound = $IndicatorRound
@onready var skill_container: Node3D = $SkillContainer

func update_indicator(pos: Vector3, scale_value: float = 1, material: StandardMaterial3D = null):
	indicator_round.show()
	indicator_round.set_indicator_scale(scale_value)
	indicator_round.global_position = pos
	if material != null:
		indicator_round.set_indicator_material(material)

func hide_indicator():
	indicator_round.hide()

func use_skill_card(card: Card):
	print(card)
	if not card.card_data.skill:
		printerr("未设置skill属性: ", card)
		return
	var skill_scene = card.card_data.skill.instantiate() as SkillBase
	skill_scene.position = indicator_round.position
	skill_scene.scale = indicator_round.scale
	skill_container.add_child(skill_scene)
	skill_scene.play_animation()
