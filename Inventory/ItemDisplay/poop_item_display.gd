extends Button

@export var type: Poop.PoopType

@onready var label = $HBoxContainer/Label
@onready var poop_icon = $HBoxContainer/PoopIcon



# Called when the node enters the scene tree for the first time.
func _ready():
	update_display()
	Inventory.Changed.connect(_on_inventory_change)
	poop_icon.texture = SceneList.poop_sprites[type]
	GameState.gamestate_change.connect(_on_gamestate_change)

func update_display():
	var poops = Inventory.get_poops(type)
	label.text = str(poops)

func _on_inventory_change():
	update_display()


func _on_pressed():
	print("selected " + str(type))
	GameState.set_held_poop(type)

func _on_gamestate_change():
	if (GameState.held_poop == type):
		grab_focus()
	else:
		release_focus()
