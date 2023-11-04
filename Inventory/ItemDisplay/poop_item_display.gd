extends Node

@export var type: Poop.PoopType

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()
	Inventory.Changed.connect(_on_inventory_change)

func update_display():
	var poops = Inventory.get_poops(type)
	label.text = str(poops)

func _on_inventory_change():
	update_display()
