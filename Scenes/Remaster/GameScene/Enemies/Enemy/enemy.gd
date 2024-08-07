extends CharacterBody2D

@export var speed = 200

@export var navigation_region: NavigationRegion2D
@export var target: Node2D

@export_group("Components")
@export var sprite: AnimatedSprite2D
@export var collision_shape: CollisionShape2D
@export var navigation_agent: NavigationAgent2D

func _ready() -> void:
	set_physics_process(false)
	call_deferred("_enable_physics")

func _physics_process(delta: float) -> void:
	if (navigation_region):
		_navigate()

func _enable_physics():
	await get_tree().physics_frame
	set_physics_process(true)

func _navigate():
	if (!navigation_region):
		return
	
	if (!target):
		return
	
	print("navigating")
	navigation_agent.target_position = target.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position() * speed)
	move_and_slide()
