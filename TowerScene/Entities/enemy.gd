class_name Enemy
extends CharacterBody2D

signal died(obj)

@export var health: Health
@export var path_follow: PathFollow2D
@export var sprite: Sprite2D

var _dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	health.init(100)
	health.health_changed.connect(_on_health_changed)
	position = path_follow.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position.x += 0.9
	path_follow.progress += 64.0 * delta
	position = path_follow.position
	rotation = path_follow.rotation
	pass

func hit(projectile: Projectile, damage: int):
	health.takeDamage(damage)

func _on_health_changed(obj, health):
	print("_on_health_changed ", obj, health)
	if health <= 0:
		_dead = true
		emit_signal("died", self)
		queue_free()
