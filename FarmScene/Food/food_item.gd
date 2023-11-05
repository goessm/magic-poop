class_name FoodItem
extends Node

@export var type: FoodType
@export var digest_time: float = 1.0

@onready var collision_area = $CollisionArea
@onready var animation_player = $AnimationPlayer
@onready var follow_mouse: FollowMouse = $FollowMouse
@onready var sprite_2d: Sprite2D = $Sprite2D

var getting_eaten_currently = false

enum FoodType {
	Apple,
	Cherry,
	Banana,
	Watermelon
}

func _ready():
	# group for food detection
	collision_area.add_to_group(Groups.Food)
	collision_area.input_event.connect(_on_collision_area_input_event)
	sprite_2d.texture = SceneList.food_sprites[type]

func get_eaten():
	SoundEffects.stream = SceneList.eat_sound
	SoundEffects.play()
	follow_mouse.follow = false
	animation_player.play("get_eaten")

func eaten_animation_finished():
	queue_free()


func _on_collision_area_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		_on_clicked()

func _on_clicked():
	follow_mouse.follow = true
