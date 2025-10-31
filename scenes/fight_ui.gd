extends Control

@onready var card_container: CardContainer = $CardContainer
@onready var card_shower: CardShower = $CardShower

func _ready() -> void:
	card_container.show_card.connect(_on_show_card)

func _on_show_card(index: int):
	var cards: Array = card_container.get_cards()
	if index != -1:
		var card := cards[index] as Card
		card_shower.set_texture(card.get_texture())
		card_shower.set_shower_position(card.position)
	else:
		card_shower.set_texture(null)
