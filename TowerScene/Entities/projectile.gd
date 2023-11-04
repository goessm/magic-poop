class_name Projectile
extends Area2D

@export var direction: Vector2
@export var speed: float
@export var collision_shape: CollisionShape2D
var lived_seconds: float = 0.0
var damage = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 800.0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	lived_seconds += delta
	if lived_seconds > 5.0:
		queue_free()
	
	var rot_speed = rad_to_deg(30)  # 30 deg/sec
	set_rotation(get_rotation() + rot_speed * delta)
	
	position += delta * speed * direction
	pass


func _on_body_entered(body):
	body.hit(self, damage)
	queue_free()
	pass # Replace with function body.
