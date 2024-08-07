extends Node2D

@export_group("Components")
@export var sightline: Area2D
@export var attack_timer: Timer

func _on_attack_timer_timeout() -> void:
	if (!_is_enemy_in_sight()):
		return
	
	_shoot_apple()

func _is_enemy_in_sight():
	return sightline.has_overlapping_bodies()

func _shoot_apple():
	pass
