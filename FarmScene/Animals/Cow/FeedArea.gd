extends Area2D

func _on_area_entered(area: Area2D):
	if area.is_in_group(Groups.Food):
		var food = area.get_parent()
		if food is FoodItem:
			pass
