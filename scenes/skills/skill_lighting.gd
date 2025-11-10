class_name  SkillLighting
extends SkillBase
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D

func play_animation():
	gpu_particles_3d.restart()
