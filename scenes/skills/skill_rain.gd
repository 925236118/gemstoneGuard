extends SkillBase

@onready var cloud: GPUParticles3D = $CloudContainer/Cloud
@onready var rain: GPUParticles3D = $CloudContainer/Rain

func play_animation():
	cloud.restart()
	rain.restart()
