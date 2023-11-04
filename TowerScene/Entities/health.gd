class_name Health
extends Node

signal health_changed(obj, health)
@export var health: int
@export var max_health: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init(_max_health: int):
	health = _max_health
	max_health = _max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#takeDamage(1)
	pass

func takeDamage(dmg: int):
	health -= dmg
	emit_signal("health_changed", self, health)

func is_dead():
	return health <= 0

func heal(amount: int):
	health += amount
	health = min(health, max_health)
	emit_signal("health_changed", self, health)

func heal_to(new_health: int):
	health = new_health
	emit_signal("health_changed", self, health)
