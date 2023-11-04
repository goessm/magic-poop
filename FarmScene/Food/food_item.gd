class_name FoodItem
extends Node

@export var type: FoodType
@onready var collision_area = $CollisionArea


enum FoodType {
	Apple,
	Orange
}

func _ready():
	# group for food detection
	collision_area.add_to_group(Groups.Food)

func get_eaten():
	queue_free()
