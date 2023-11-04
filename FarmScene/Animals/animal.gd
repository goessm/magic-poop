class_name Animal
extends Node2D

# Animal is nice guy u feed and it poops

@export var poopScene: PackedScene

@onready var animation_player = $AnimationPlayer
@onready var poop_timer = $PoopTimer

func _ready():
	poop_timer.timeout.connect(poop)

var allow_to_be_moved := true

func digest_food(food: FoodItem):
	pass

func poop():
	animation_player.play("poop")

func move(direction: Vector2):
	position += direction

func _spawn_poop():
	var poop = poopScene.instantiate()
	get_parent().add_child(poop)
	poop.position = position
