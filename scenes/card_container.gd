class_name CardContainer
extends Control

signal show_card(index: int)

# 卡牌间最大间距
const MAX_CARD_SPAN = 100
# 卡牌容器最大宽度
const MAX_CONTAINER_WIDTH = 500
# 卡牌容器一半宽度，方便后续计算
const HALF_MAX_CONTAINER_WIDTH = MAX_CONTAINER_WIDTH / 2.0
# 卡牌容器半扇幅角度，影响卡牌开扇后的角度
const CONTAINER_ARC_DEGREE = 20.0

func _ready() -> void:
	update_cards_position()
	var cards = get_cards()
	connect_all_card_signals(cards)

func get_cards() -> Array:
	return get_children()

# 重新计算所有卡牌位置
func update_cards_position():
	var card_count = get_child_count()
	# 计算卡牌间距
	var card_span = 0
	if card_count <= 1:
		card_span = MAX_CARD_SPAN
	else:
		card_span = min(MAX_CARD_SPAN, float(MAX_CONTAINER_WIDTH) / (card_count - 1))
	# 计算卡牌平铺后实际需要宽度
	var card_need_width = card_span * (card_count - 1)

	# 循环设置卡牌属性
	for index in card_count:
		# 计算坐标
		var card_pos = Vector2(global_position)
		# x
		var pos_offset = index * card_span - card_need_width / 2
		card_pos.x = card_pos.x + pos_offset
		# y
		if pos_offset != 0:
			var r = abs(pos_offset) / sin((abs(pos_offset) / HALF_MAX_CONTAINER_WIDTH) * (CONTAINER_ARC_DEGREE / 180))
			var current_y = abs(pos_offset) / tan((abs(pos_offset) / HALF_MAX_CONTAINER_WIDTH) * (CONTAINER_ARC_DEGREE / 180))
			var card_y_pos = r - current_y
			card_pos.y = card_pos.y  + card_y_pos * 3

		# 计算旋转
		var card_rotation_degree = lerp(-CONTAINER_ARC_DEGREE, CONTAINER_ARC_DEGREE, float(pos_offset + HALF_MAX_CONTAINER_WIDTH) / MAX_CONTAINER_WIDTH)

		# 设置属性
		var card = get_child(index) as Card
		card.global_position = card_pos
		card.rotation_degrees = card_rotation_degree

# 为所有卡牌绑定信号
func connect_all_card_signals(cards: Array):
	for card: Card in cards:
		connect_card_signals(card)

# 为某一个卡牌绑定信号
func connect_card_signals(card: Card):
	card.hover.connect(_on_card_mouse_entered.bind(card))
	card.hover_end.connect(_on_card_mouse_exited.bind(card))

func set_card_texture_visible(index: int):
	for card in get_children():
		card.set_texture_visible(card.get_index() != index)

# 鼠标移入后隐藏该卡牌，并显示展示卡牌节点
func _on_card_mouse_entered(card: Card):
	#card.set_texture_visible(false)
	show_card.emit(card.get_index())

# 鼠标移出后显示该卡牌，并隐藏展示卡牌节点
func _on_card_mouse_exited(card: Card):
	#card.set_texture_visible(true)
	show_card.emit(-1)
