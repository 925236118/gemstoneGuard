extends SkillBaseCircle

@onready var cloud: GPUParticles3D = $CloudContainer/Cloud
@onready var rain: GPUParticles3D = $CloudContainer/Rain

func play_animation():
	cloud.restart()
	rain.restart()

func set_skill_range(radius: float):
	cloud.process_material.emission_ring_radius = radius
	rain.process_material.emission_ring_radius = radius
	cloud.amount = int(6 * radius * radius)
	rain.amount = int(50 * radius * radius)
