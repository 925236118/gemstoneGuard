class_name WeaponContainer
extends Node3D

var radius = 0.75
var weapons = []

func _ready() -> void:
	weapons = get_children()
	update_weapons_position()

func add_weapon(weapon: WeaponBase):
	add_child(weapon)
	weapons.push_back(weapon)
	update_weapons_position()

# 更新武器位置
func update_weapons_position():
	var start_vector = Vector3(0, 0, radius)
	var each_angle = PI * 2 / weapons.size()
	for index in weapons.size():
		var weapon := weapons[index] as Node3D
		weapon.position = start_vector.rotated(Vector3.UP, each_angle * index)
		weapon.rotate_y(each_angle * index)
