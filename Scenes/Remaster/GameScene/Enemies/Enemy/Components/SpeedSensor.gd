class_name SpeedSensor
extends Node2D

@export_group("Settings")
@export var measure_object: Node2D

var last_pos: Vector2
var first_frame := true

var measured_speed := 0.0

func get_speed() -> float:
	return measured_speed

func _physics_process(delta: float) -> void:
	if (!measure_object):
		measure_object = self
	
	if (first_frame):
		last_pos = measure_object.global_position
		first_frame = false
		return
	
	var distance_moved = measure_object.global_position.distance_squared_to(last_pos)
	measured_speed = distance_moved
	
	last_pos = measure_object.global_position
