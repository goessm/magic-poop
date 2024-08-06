#@tool
extends Button

@export var item: Item

@export_group("Children")
@export var image: TextureRect
@export var label: Label

func _ready():
	if (item):
		print("Item: " + Item.Items.keys()[item.type])
		print(item.texture)
		print(image)
		image.texture = item.texture
