class_name Enemy
extends Node2D

@export var health: Health
@export var path_follow: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	health.health_changed.connect(_on_health_changed)
	position = path_follow.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position.x += 0.9
	#path_follow.progress_ratio
	path_follow.progress += 64.0 * delta
	position = path_follow.position
	rotation = path_follow.rotation
	#%Path2D/PathFollow2D.progress

func _on_health_changed(obj, health):
	print("_on_health_changed ", obj, health)
