class_name Animal
extends CharacterBody2D

# Animal is nice guy u feed and it poops

@export var poopScene: PackedScene

@onready var animation_player = $AnimationPlayer
@onready var poop_timer = $PoopTimer
@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	poop_timer.timeout.connect(poop)

var allow_to_be_moved := true

func digest_food(food: FoodItem):
	print("digesting")
	poop_timer.start(food.digest_time)

func poop():
	print("pooping")
	animation_player.play("poop")

func poop_animation_finished():
	_spawn_poop()

func move(direction: Vector2):
	velocity = direction
	move_and_slide()
	#position += direction
	animated_sprite.flip_h = direction.x < 0
	

func _spawn_poop():
	var poop = poopScene.instantiate()
	get_parent().add_child(poop)
	poop.position = position
