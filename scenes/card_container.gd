class_name CardContainer
extends Control

const CARD_SIZE = Vector2(150, 200)
const MAX_CARD_SPAN = 100
const MAX_CONTAINER_WIDTH = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_cards_position()

# 重新计算所有卡牌位置
func update_cards_position():
	var card_count = get_child_count()
	
	var card_span = 0
	if card_count <= 1:
		card_span = MAX_CARD_SPAN
	else:
		card_span = min(MAX_CARD_SPAN, float(MAX_CONTAINER_WIDTH) / (card_count - 1))
	var card_need_width = card_span * (card_count - 1)
	for index in card_count:
		# 计算坐标
		var card_pos = Vector2(global_position)
		var pos_offset = index * card_span - card_need_width / 2
		card_pos.x = card_pos.x + pos_offset
		# 计算y坐标
		var r = abs(pos_offset) / sin(20.0 / 180)
		var current_y = abs(pos_offset) / tan(20.0 / 180)
		var card_y_pos = current_y - r
		card_pos.y = card_pos.y  - card_y_pos * 3
		
		# 计算旋转
		var card_rotation_degree = lerp(-20, 20, float(pos_offset + float(MAX_CONTAINER_WIDTH) / 2) / 500)
		
		# 设置属性
		var card = get_child(index) as Card
		card.global_position = card_pos
		card.rotation_degrees = card_rotation_degree
		pass
