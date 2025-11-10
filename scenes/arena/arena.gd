class_name Arena
extends Node3D
# indicator 技能指示器
@onready var indicator_round: IndicatorRound = $IndicatorContainer/IndicatorRound
@onready var indicator_point: Node3D = $IndicatorContainer/IndicatorPoint

@onready var skill_container: Node3D = $SkillContainer

class IndicatorParams:
	var type: CardData.SkillType
	var pos: Vector3
	var scale_value: float
	var material: StandardMaterial3D

func update_indicator(params: IndicatorParams):
	match params.type:
		CardData.SkillType.CIRCLE:
			indicator_round.show()
			indicator_round.set_indicator_scale(params.scale_value)
			indicator_round.global_position = params.pos
			if params.material != null:
				indicator_round.set_indicator_material(params.material)
		CardData.SkillType.SINGLE:
			indicator_point.show()
			indicator_point.global_position = params.pos

func hide_indicator():
	indicator_round.hide()
	indicator_point.hide()

func use_skill_card(card: Card):
	#print(card)
	if not card.card_data.skill:
		printerr("未设置skill属性: ", card)
		return
	var skill_scene = card.card_data.skill.instantiate() as SkillBase
	skill_container.add_child(skill_scene)
	if card.card_data.skill_type == CardData.SkillType.CIRCLE:
		skill_scene.position = indicator_round.position
		skill_scene.set_skill_range(card.card_data.skill_range)
	elif card.card_data.skill_type == CardData.SkillType.SINGLE:
		skill_scene.position = indicator_point.position
	skill_scene.play_animation()
