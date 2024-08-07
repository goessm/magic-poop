extends Area2D

@export var damage = 1
@export var direction: Vector2
@export var speed: float = 800.0
@export var rotation_speed := 5.0

@export_group("Components")
@export var sprite: Sprite2D
@export var collision_shape: CollisionShape2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	set_rotation(get_rotation() + rotation_speed * delta)
	
	position += delta * speed * direction

func _on_body_entered(body: Node2D):
	if (body.has_method("get_hit_by_bullet")):
		body.get_hit_by_bullet(damage)
		queue_free()

func _on_despawn_timer_timeout() -> void:
	queue_free()
