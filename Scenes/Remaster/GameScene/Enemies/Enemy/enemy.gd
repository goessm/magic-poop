extends CharacterBody2D

@export var speed = 2000

@export var navigation_region: NavigationRegion2D
@export var target: Node2D

@export_group("Components")
@export var flip_on_turn: Node2D
@export var sprite: AnimatedSprite2D
@export var collision_shape: CollisionShape2D
@export var navigation_agent: NavigationAgent2D

func _ready() -> void:
	set_physics_process(false)
	call_deferred("_enable_physics")

func _physics_process(delta: float) -> void:
	if (navigation_region):
		_navigate(delta)

func _enable_physics():
	await get_tree().physics_frame
	set_physics_process(true)

func _navigate(delta: float):
	const target_deadzone = 10
	
	if (!navigation_region):
		return
	
	if (!target):
		return
	
	navigation_agent.target_position = target.global_position
	
	if (navigation_agent.get_next_path_position().distance_to(global_position) < target_deadzone):
		return
	
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * speed * delta
	
	move_and_slide()
	
	_set_facing_direction()

func _set_facing_direction():
	var flip = velocity.x > 0
	var new_scale_x = abs(flip_on_turn.scale.x) if flip else -(abs(flip_on_turn.scale.x))
	flip_on_turn.scale = Vector2(new_scale_x, flip_on_turn.scale.y)
