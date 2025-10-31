class_name Card
extends Control

@onready var texture_container: Control = $TextureContainer
@onready var sub_viewport: SubViewport = $TextureContainer/SubViewportContainer/SubViewport

signal hover
signal hover_end

# 卡牌尺寸
static var CARD_SIZE = Vector2(150, 200)

func set_texture_visible(visible_value: bool):
	texture_container.modulate = Color(1,1,1,1) if visible_value else Color(1,1,1,0)

func _on_texture_container_mouse_entered() -> void:
	hover.emit()

func _on_texture_container_mouse_exited() -> void:
	hover_end.emit()

func get_texture() -> ViewportTexture:
	return sub_viewport.get_texture()
