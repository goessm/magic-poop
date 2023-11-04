class_name FoodItem
extends Node

@export var type: FoodType
@export var digest_time: float = 1.0

@onready var collision_area = $CollisionArea
@onready var animation_player = $AnimationPlayer
@onready var follow_mouse: FollowMouse = $FollowMouse

enum FoodType {
	Apple,
	Orange
}

func _ready():
	# group for food detection
	collision_area.add_to_group(Groups.Food)

func get_eaten():
	follow_mouse.follow = false
	animation_player.play("get_eaten")

func eaten_animation_finished():
	queue_free()
