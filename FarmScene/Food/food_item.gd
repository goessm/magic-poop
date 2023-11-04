class_name FoodItem
extends Node

@export var type: FoodType
@onready var collision_area = $CollisionArea
@onready var animation_player = $AnimationPlayer


enum FoodType {
	Apple,
	Orange
}

func _ready():
	# group for food detection
	collision_area.add_to_group(Groups.Food)

func get_eaten():
	animation_player.play("get_eaten")

func eaten_animation_finished():
	queue_free()
