class_name WandItem
extends PanelContainer

@onready var label: Label = $Label


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_released("mouse_click"):
		ArenaState.instance.card_used_wand_index = get_index()

func use_card(card: Card):
	label.text = card.card_data.name
