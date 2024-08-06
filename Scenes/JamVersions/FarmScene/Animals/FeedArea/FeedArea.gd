extends Area2D

@onready var animal = $"../.."

func _on_area_entered(area: Area2D):
	if area.is_in_group(Groups.Food):
		var food = area.get_parent()
		if food is FoodItem:
			eat_food(food)

func eat_food(food: FoodItem):
	print("I ate a " + str(food.type))
	animal.digest_food(food)
	food.get_eaten()
