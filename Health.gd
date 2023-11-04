extends Node

signal health_changed(obj, health)
@export var health: int

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 10000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	takeDamage(1)

func takeDamage(dmg: int):
	health -= dmg
	emit_signal("health_changed", self, health)
	
