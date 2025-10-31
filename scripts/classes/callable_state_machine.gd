class_name CallableStateMachine

# 保存状态函数的字典
var state_dictionary = {}
# 当前状态的名称
var current_state: String

# 添加状态，需要传入每帧运行、进入状态、离开状态
func add_states(
	normal_state_callable: Callable,
	enter_state_callable: Callable,
	leave_state_callable: Callable
):
	state_dictionary[normal_state_callable.get_method()] = {
		"normal": normal_state_callable,
		"enter": enter_state_callable,
		"leave": leave_state_callable
	}

# 设置初始状态
func set_initial_state(state_callable: Callable):
	var state_name = state_callable.get_method()
	if state_dictionary.has(state_name):
		_set_state(state_name)
	else:
		push_warning("No state with name " + state_name)

# 状态机每帧调用当前状态的normal函数
func update(delta: float):
	if current_state != null:
		(state_dictionary[current_state].normal as Callable).call(delta)

# 切换状态，需要传入要切换的状态的normal函数
func change_state(state_callable: Callable):
	var state_name = state_callable.get_method()
	if state_dictionary.has(state_name):
		_set_state.call_deferred(state_name)
	else:
		push_warning("No state with name " + state_name)

# 内置设置状态函数
func _set_state(state_name: String):
	if current_state:
		var leave_callable = state_dictionary[current_state].leave as Callable
		if !leave_callable.is_null():
			leave_callable.call()

	current_state = state_name
	var enter_callable = state_dictionary[current_state].enter as Callable
	if !enter_callable.is_null():
		enter_callable.call()
