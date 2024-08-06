extends Camera2D

@export var speed = 25.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var inputX = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var inputY = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
	position = get_screen_center_position() + Vector2(inputX, inputY) * delta * speed
