class_name Card
extends Control

# 卡牌容器
# 没有尺寸

@onready var texture_container: Control = $TextureContainer
@onready var card_viewport: SubViewport = $TextureContainer/SubViewportContainer/SubViewport
@onready var texture_control: Control = $TextureContainer/SubViewportContainer/SubViewport/TextureControl
@onready var card_name: Label = %CardName
@onready var card_description: Label = %CardDescription
@onready var card_texture_scene_conrainer: Node3D = $TextureContainer/SubViewportContainer/SubViewport/TextureControl/MarginContainer/SubViewportContainer/SubViewport/CardTextureSceneConrainer
@onready var card_texture_animation_player: AnimationPlayer = $TextureContainer/SubViewportContainer/SubViewport/TextureControl/MarginContainer/SubViewportContainer/SubViewport/CardTextureSceneConrainer/AnimationPlayer

signal hover
signal hover_end

@export var card_data: CardData = null

var is_hover: bool = false

# 卡牌尺寸
static var CARD_SIZE = Vector2(150, 200)

func _ready() -> void:
	if card_data != null:
		card_name.text = card_data.name
		card_description.text = card_data.description
		if card_data.type == CardData.CardType.WEAPON:
			var weapon_scene = card_data.weapon.instantiate() as WeaponBase
			card_texture_scene_conrainer.add_child(weapon_scene)


# 设置纹理是否展示，不会影响鼠标事件，仅视觉效果
func set_texture_visible(visible_value: bool):
	texture_container.modulate = Color(1, 1, 1, 1) if visible_value else Color(1, 1, 1, 0)
	pass

# 处理鼠标事件
func _on_texture_container_mouse_entered() -> void:
	is_hover = true
	hover.emit()

func _on_texture_container_mouse_exited() -> void:
	is_hover = false
	hover_end.emit()

# 获得卡牌的纹理供展示使用
func get_texture() -> ViewportTexture:
	return card_viewport.get_texture()

func play_card_texture_animation():
	if not card_texture_animation_player.is_playing():
		print("play card texture animation")
		card_texture_animation_player.play("loop")

func stop_card_texture_animation():
	card_texture_animation_player.stop()
