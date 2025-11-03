class_name CardData
extends Resource

## 卡牌数据

enum CardType {
	NONE,
	WEAPON,
	SKILL,
	BUFF
}

enum SkillType {
	NONE,
	CIRCLE,
	SINGLE,
	RAY
}

@export_group("common")
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

@export_group("skill", "skill")
# 技能类型
@export var skill_type: SkillType = SkillType.NONE
# 技能图标
@export var skill_icon: Texture2D = null
# 技能范围
@export var skill_range: int = 0
