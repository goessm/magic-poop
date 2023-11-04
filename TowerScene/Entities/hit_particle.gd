extends Node2D

var time_alive: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_alive += delta
	if time_alive > 1.0:
		queue_free()
	position.y -= delta * 16.0
	position.x = 10.0 * sin(time_alive * 6.0)
	pass
