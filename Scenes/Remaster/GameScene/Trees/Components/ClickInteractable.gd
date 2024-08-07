extends Area2D

signal clicked(held_item: Item)

func _ready() -> void:
	input_event.connect(_on_input_event)

func _on_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		print("clicked")
		if (ItemButton.selected_button && ItemButton.selected_button.item):
			clicked.emit(ItemButton.selected_button.item)
