extends Node2D

@export var hello: int
@export var health: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	hello = 1
	health.health_changed.connect(_on_health_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	hello+=1
	position.x += 0.1

func _on_health_changed(obj, health):
	print("_on_health_changed ", obj, health)
