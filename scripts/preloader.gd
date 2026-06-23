extends Node2D

@export var all_particle_materials : Array[ParticleProcessMaterial]
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

func _ready() -> void:
	_load_all_materials()

func _load_all_materials():
	for particle : ParticleProcessMaterial in all_particle_materials:
		gpu_particles_2d.process_material = particle
		gpu_particles_2d.emitting = true
	self.visible = false
