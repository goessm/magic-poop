class_name Item

extends Resource

enum Items {
	Poop,
	PoopRainbow,
	FoodApple,
	FoodBanana,
}

@export var type: Items
@export var texture: Texture2D

@export var fertilize_power: int
