extends StaticBody2D

enum GrowthStage {
	Seed,
	Growing,
	Grown
}

@export var fruit_type: FoodItem.FoodType
@export var fruit_parent: NodePath

var fruit: FoodItem
var fruitScene: PackedScene

var stage: GrowthStage = GrowthStage.Seed

func spawn_fruit():
	if (fruit):
		# old fruit still exists, don't spawn
		return
	
	var spawned_fruit: FoodItem = SceneList.food_item_scene.instantiate()
	spawned_fruit.type = fruit_type
	get_node(fruit_parent).add_child(spawned_fruit)
	fruit = spawned_fruit


func _on_grow_timer_timeout():
	if (stage != GrowthStage.Grown):
		spawn_fruit()
	else:
		grow_tree()

func grow_tree():
	stage = stage + 1
	_update_sprite()

func _update_sprite():
	match (stage):
		GrowthStage.Seed:
			pass
		GrowthStage.Growing:
			pass
