class_name Card
extends Control

# 卡牌容器
# 没有尺寸

@onready var texture_container: Control = $TextureContainer
@onready var card_viewport: SubViewport = $TextureContainer/SubViewportContainer/SubViewport
@onready var texture_control: Control = $TextureContainer/SubViewportContainer/SubViewport/TextureControl

signal hover
signal hover_end

var is_hover: bool = false

# 卡牌尺寸
static var CARD_SIZE = Vector2(150, 200)

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
