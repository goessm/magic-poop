class_name Poop
extends Node2D

enum PoopType {
	Default,
	Rainbow,
	Rabbit
}

@export var type: PoopType


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		on_collected()

func on_collected():
	Inventory.add_poop(type)
	queue_free()
