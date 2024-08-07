class_name ItemButton
#@tool
extends Button

@export var item: Item

@export_group("Children")
@export var image: TextureRect
@export var label: Label

static var selected_button: ItemButton

func _ready():
	if (item):
		print("Item: " + Item.Items.keys()[item.type])
		print(item.texture)
		print(image)
		image.texture = item.texture


func _on_pressed() -> void:
	print("button pressed")
	print(item.type)
	grab_focus()
	selected_button = self
