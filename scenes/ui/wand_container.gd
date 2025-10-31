class_name WandContainer
extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer

func get_wand_item(index: int):
	return v_box_container.get_child(index)
