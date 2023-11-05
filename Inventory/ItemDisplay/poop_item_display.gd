extends Node

@export var type: Poop.PoopType

@onready var label = $HBoxContainer/Label
@onready var poop_icon = $HBoxContainer/PoopIcon



# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()
	Inventory.Changed.connect(_on_inventory_change)
	poop_icon.texture = SceneList.poop_sprites[type]

func update_display():
	var poops = Inventory.get_poops(type)
	label.text = str(poops)

func _on_inventory_change():
	update_display()


func _on_pressed():
	print("selected " + str(type))
	GameState.held_poop = type
