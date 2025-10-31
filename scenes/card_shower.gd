class_name CardShower
extends Control

@onready var texture_rect: TextureRect = $TextureRect

func set_texture(texture: ViewportTexture):
	texture_rect.texture = texture

func set_shower_position(pos: Vector2):
	texture_rect.position.x = pos.x - Card.CARD_SIZE.x / 2
	texture_rect.position.y = -Card.CARD_SIZE.y
	pass
