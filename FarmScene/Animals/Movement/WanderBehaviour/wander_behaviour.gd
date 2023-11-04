extends Node

const start_moving_chance := 0.3
const stop_moving_chance := 0.6

@export var speed := 50.0

@onready var parent: Cow = $".."

var goalDirection: Vector2 # the direction I want to wander in

func _process(delta):
	movement_tick(delta)

func movement_tick(delta):
	if goalDirection != Vector2.ZERO:
		move_in_direction(goalDirection, delta)

func move_in_direction(position: Vector2, delta):
	if "allow_to_be_moved" not in parent:
		print("Parent of wanderbehaviour is not moveable")
		return
		
	if !parent.allow_to_be_moved:
		return
	
	parent.move(goalDirection * speed * delta)
	

func find_new_direction():
	var is_moving = goalDirection != Vector2.ZERO
	
	if (is_moving && randf() <= stop_moving_chance):
		# Decide to stop moving
		print("stopped moving")
		goalDirection = Vector2.ZERO
	
	if (!is_moving && randf() <= start_moving_chance):
		# Decide to start moving
		print("started moving")
		goalDirection = Vector2(randf_range(-1, 1), randf_range(-1, 1))


func _on_decision_timer_timeout():
	find_new_direction()
