class_name CardManager
extends Node

#region 单例相关
# 静态变量保存单例实例
static var instance: CardManager = null

func _ready():
	# 如果实例已存在，销毁当前节点
	if instance != null:
		push_warning("当前节点树中已经存在单例实例")
		queue_free()
		return
	# 否则将自己设为实例
	instance = self

func _exit_tree():
	# 节点被销毁时清空实例引用
	if instance == self:
		instance = null
#endregion

@onready var card_datas = [
	# 武器
	load("uid://kdakl74cribb"),  # 圆盾
	load("uid://cpqek4niqipue"), # 法杖
	load("uid://cmg4wfw072knw"), # 短剑
	load("uid://db7sjasp6eshl"), # 长剑

	# 技能
	load("uid://cedd1qwxu4qq0"), # 暴雨术
	load("uid://dp6qurv72nbjv"), # 落雷qq



]
