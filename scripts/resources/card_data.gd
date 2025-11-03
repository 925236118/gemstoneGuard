class_name CardData
extends Resource

## 卡牌数据

enum CardType {
	NONE,
	WEAPON,
	SKILL,
	BUFF
}

@export var type: CardType = CardType.NONE

# 卡牌名称
@export var name: String = ""

# 卡牌描述
@export var description: String = ""

# 武器
@export var weapon: PackedScene = null

# 技能
@export var skill: PackedScene = null

# 增益
@export var buff: PackedScene = null
