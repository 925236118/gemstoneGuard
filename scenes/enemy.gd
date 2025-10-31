class_name Enemy
extends CharacterBody3D

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

const GEMSTONE_POS = Vector3.ZERO
const GEMSTONE_RADIUS = 1

const SPEED = 3.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	init_navigation_info()

func init_navigation_info():
	var random_target = Vector2(randf_range(0, GEMSTONE_RADIUS) - GEMSTONE_RADIUS / 2.0, randf_range(0, GEMSTONE_RADIUS) - GEMSTONE_RADIUS / 2.0)
	navigation_agent_3d.target_position = GEMSTONE_POS + Vector3(random_target.x, 0, random_target.y)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction := (navigation_agent_3d.get_next_path_position() - global_position).normalized()
	
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	if navigation_agent_3d.distance_to_target() > 2.5:
		move_and_slide()
