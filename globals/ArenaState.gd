class_name ArenaState
extends Node

#region 单例相关
# 静态变量保存单例实例
static var instance: ArenaState = null

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

signal start_use_card
