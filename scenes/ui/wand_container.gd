class_name WandContainer
extends Control

const WAND_ITEM = preload("uid://cocbjnf8bnxxr")

@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	for i in ArenaState.instance.weapon_count:
		v_box_container.add_child(WAND_ITEM.instantiate())

func get_wand_item(index: int):
	return v_box_container.get_child(index)
