class_name GrowthStages
extends Node

@export var growth_stage_count := 3
@export var growth_stage := 0:
	get = _get_growth_stage,
	set = _set_growth_stage

@export_group("Dependencies")
@export var sprite: AnimatedSprite2D
@export var grow_fx: GPUParticles2D

const growAnimationName := "grow"

func _get_growth_stage() -> int:
	return growth_stage

func _set_growth_stage(stage: int):
	if (growth_stage == stage):
		return
	
	growth_stage = clampi(stage, 0, growth_stage_count - 1)
	
	sprite.play(growAnimationName)
	sprite.pause()
	sprite.frame = growth_stage
	
	if (grow_fx):
		grow_fx.emitting = true

func is_fully_grown() -> bool:
	return growth_stage >= growth_stage_count - 1
