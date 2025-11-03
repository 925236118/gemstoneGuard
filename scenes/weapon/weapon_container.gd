class_name WeaponContainer
extends Node3D

var radius = 0.75
var weapons: Array[WeaponBase] = []
var weapon_cards: Array[CardData] = []

func _ready() -> void:
	ArenaState.instance.weapon_container = self
	weapons.resize(ArenaState.instance.weapon_count)
	weapon_cards.resize(ArenaState.instance.weapon_count)
	print(weapon_cards)

# 更新武器位置
func update_weapons_position():
	var start_vector = Vector3(0, 0, radius)
	var used_weapon = weapons.filter(func (w): return w != null)
	var each_angle = PI * 2 / used_weapon.size()
	for index in used_weapon.size():
		var weapon := used_weapon[index] as WeaponBase
		weapon.position = start_vector.rotated(Vector3.UP, each_angle * index)
		weapon.rotate_y(each_angle * index)

func replace_weapon(index: int, card: Card) -> CardData:
	var old_card = null
	if weapon_cards[index]:
		old_card = weapon_cards.pop_at(index)
	if weapons[index] != null:
		weapons[index].queue_free()
	var weapon = card.card_data.weapon.instantiate() as WeaponBase
	add_child(weapon)
	weapons[index] = weapon
	weapon_cards.insert(index, card.card_data)

	update_weapons_position()
	return old_card
