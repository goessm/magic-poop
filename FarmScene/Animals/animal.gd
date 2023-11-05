class_name Animal
extends CharacterBody2D

# Animal is nice guy u feed and it poops

enum AnimalType {
	Sheep,
	Dino,
	Turtle
}

@export var animalType: AnimalType
@export var poopScene: PackedScene

@onready var animation_player = $AnimationPlayer
@onready var poop_timer = $PoopTimer
@onready var flip_on_turn = $FlipOnTurn
@onready var animated_sprite = $FlipOnTurn/AnimatedSprite2D
@onready var poop_hole = $FlipOnTurn/PoopHole




func _ready():
	_configure_animal_type()
	poop_timer.timeout.connect(poop)

func _physics_process(delta):
	move_and_slide()
	
	if (velocity.length() <= 0.01 && animated_sprite.animation == "run"):
		animated_sprite.play("idle")
	

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
	
	if (direction == Vector2.ZERO):
		return # not moving
	
	if (animated_sprite.animation != "run"):
		animated_sprite.play("run")
	
	flip_on_turn.scale.x = -1 if direction.x < 0 else 1

func eat_grass():
	if (animated_sprite.animation == "idle" || !animated_sprite.is_playing()):
		animated_sprite.play("bite")

func _spawn_poop():
	var poop = poopScene.instantiate()
	get_parent().get_node("Poops").add_child(poop)
	poop.global_position = poop_hole.global_position

func _configure_animal_type():
	poopScene = SceneList.animal_poops[animalType]
	animated_sprite.sprite_frames = SceneList.animal_sprites[animalType]
