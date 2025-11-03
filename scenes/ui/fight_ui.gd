class_name FightUI
extends Control

@onready var card_container: CardContainer = $CardContainer
@onready var card_shower: CardShower = $CardShower
@onready var line_2d: Line2D = $DraggingLineContainer/Line2D
@onready var wand_container: WandContainer = $WandContainer

# 状态机
var state_machine: CallableStateMachine = CallableStateMachine.new()

# 当前状态
var current_state: String:
	get:
		return state_machine.current_state
	set(value):
		state_machine.change_state(Callable.create(self, value))

func _process(delta: float) -> void:
	state_machine.update(delta)

func _ready() -> void:
	state_machine.add_states(state_idle, enter_state_idle, leave_state_idle)
	state_machine.add_states(state_hover, enter_state_hover, leave_state_hover)
	state_machine.add_states(state_dragging, enter_state_dragging, leave_state_dragging)
	state_machine.add_states(state_drop, enter_state_drop, leave_state_drop)
	state_machine.set_initial_state(state_idle)

# 展示卡牌
func _on_show_card(index: int):
	showing_card_index = index

#region 状态相关
var showing_card_index = -1
var drag_mouse_pos = Vector2.ZERO
var current_card: Card = null

# 待机状态
func state_idle(_delta: float):
	if showing_card_index != -1:
		state_machine.change_state(state_hover)

func enter_state_idle():
	print("enter idle")
	showing_card_index = -1
	card_container.set_card_texture_visible(showing_card_index)
	card_shower.set_texture(null)
	card_container.show_card.connect(_on_show_card)

func leave_state_idle():
	pass

# 悬停状态
func state_hover(_delta: float):
	var cards: Array = card_container.get_cards()
	card_container.set_card_texture_visible(showing_card_index)
	if showing_card_index != -1:
		var card := cards[showing_card_index] as Card
		for card_index in cards.size():
			if card_index == showing_card_index:
				continue
			var other_card = cards[card_index] as Card
			other_card.stop_card_texture_animation()
		card.play_card_texture_animation()
		card_shower.set_texture(card.get_texture())
		card_shower.set_shower_position(card.position)
	else:
		for card in cards:
			card.stop_card_texture_animation()
		card_shower.set_texture(null)
		state_machine.change_state(state_idle)


	# 点击左键时切换到拖拽状态
	if Input.is_action_just_released("mouse_click"):
		drag_mouse_pos = get_global_mouse_position()
		state_machine.change_state(state_dragging)
		current_card = cards[showing_card_index]

func enter_state_hover():
	print("enter hover")
	pass

func leave_state_hover():
	card_container.show_card.disconnect(_on_show_card)

# 拖拽状态
func state_dragging(_delta: float):
	var curr_mouse_pos = get_global_mouse_position()
	if Input.is_action_just_released("mouse_click"):
		## 如果拖拽距离大于DROP_DISTANCE，则切换到放置状态
		## 否则不切换，可以在原位置点击
		# 由于拖动后不能触发weapon container的事件 所以暂时删除拖动逻辑
		#const DROP_DISTANCE = 10
		#if (curr_mouse_pos - drag_mouse_pos).length() > DROP_DISTANCE:
		state_machine.change_state(state_drop)
	# 如果按下取消键，则切换到待机状态
	if Input.is_action_just_pressed("mouse_cancel"):
		state_machine.change_state(state_idle)
	# 绘制拖拽线
	var curve_2d = Curve2D.new()
	var vector = (curr_mouse_pos - card_shower.get_center_pos())
	var rotate_angle = PI / 8
	if vector.x > 0:
		rotate_angle = -rotate_angle
	curve_2d.add_point(card_shower.get_center_pos(), Vector2.ZERO, vector.normalized().rotated(rotate_angle) * vector.length() / 2.0, 0)
	curve_2d.add_point(curr_mouse_pos, -vector.normalized().rotated(-rotate_angle) * vector.length() / 2.0, Vector2.ZERO, 1)

	line_2d.points = curve_2d.get_baked_points()

func enter_state_dragging():
	print("enter dragging")
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func leave_state_dragging():
	line_2d.points = []
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	pass

# 放置状态
func state_drop(_delta: float):
	pass

func enter_state_drop():
	print("enter drop")
	await get_tree().process_frame
	if ArenaState.instance.card_used_wand_index != -1:
		var card_data = current_card.card_data as CardData
		if card_data and card_data.type == CardData.CardType.WEAPON:
			print("wand slot %d use card" % ArenaState.instance.card_used_wand_index)
			var wand_item = wand_container.get_wand_item(ArenaState.instance.card_used_wand_index) as WandItem
			wand_item.use_card(current_card)
			var old_card_data = ArenaState.instance.weapon_container.replace_weapon(ArenaState.instance.card_used_wand_index, current_card)
			if old_card_data != null:
				print("需要放到弃牌堆")
				card_container.add_card(old_card_data)
			card_container.remove_card(current_card)
		else:
			print("错误的卡牌类型")
	state_machine.change_state(state_idle)

func leave_state_drop():
	current_card = null
	ArenaState.instance.card_used_wand_index = -1
#endregion
