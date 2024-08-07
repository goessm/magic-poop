extends Node2D

@export_group("Children")
@export var growth: GrowthStages

func _ready() -> void:
	growth.growth_stage = 0


func _on_click_interactable_clicked(item: Item) -> void:
	print(item.fertilize_power)
	if (item.fertilize_power > 0):
		_on_fertilize(item.fertilize_power)
		return

func _on_fertilize(fertilize_power: int):
	if (growth.is_fully_grown()):
		_turn_into_turret()
		return
	
	growth.growth_stage += 1
	if (fertilize_power > 1):
		_on_fertilize(fertilize_power - 1)


func _turn_into_turret():
	pass
