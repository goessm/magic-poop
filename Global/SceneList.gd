extends Node

# poops

const normal_poop = preload("res://FarmScene/Poop/Poop.tscn")
const sheep_poop = preload("res://FarmScene/Poop/Poops/sheep_poop.tscn")
const dino_poop = preload("res://FarmScene/Poop/Poops/dino_poop.tscn")
const turtle_poop = preload("res://FarmScene/Poop/Poops/turtle_poop.tscn")

const normal_poop_texture = preload("res://Inventory/ItemDisplay/PoopSprites/poop_sprite_normal.tres")
const sheep_poop_texture = preload("res://Inventory/ItemDisplay/PoopSprites/poop_sprite_sheep.tres")
const dino_poop_texture = preload("res://Inventory/ItemDisplay/PoopSprites/poop_sprite_dino.tres")
const turtle_poop_texture = preload("res://Inventory/ItemDisplay/PoopSprites/poop_sprite_turtle.tres")
const rainbow_poop_texture = preload("res://Inventory/ItemDisplay/PoopSprites/poop_sprite_rainbow.tres")

const animal_poops = {
	Animal.AnimalType.Sheep: sheep_poop,
	Animal.AnimalType.Dino: dino_poop,
	Animal.AnimalType.Turtle: turtle_poop
}

const poop_sprites = {
	Poop.PoopType.Default: normal_poop_texture,
	Poop.PoopType.Sheep: sheep_poop_texture,
	Poop.PoopType.Dino: dino_poop_texture,
	Poop.PoopType.Turtle: turtle_poop_texture,
	Poop.PoopType.Rainbow: rainbow_poop_texture
}

# food

const food_sprites = {
	FoodItem.FoodType.Apple: preload("res://FarmScene/Food/FoodSprites/apple_sprite.tres"),
	FoodItem.FoodType.Cherry: preload("res://FarmScene/Food/FoodSprites/cherry_sprite.tres"),
	FoodItem.FoodType.Banana: preload("res://FarmScene/Food/FoodSprites/banana_sprite.tres"),
	FoodItem.FoodType.Watermelon: preload("res://FarmScene/Food/FoodSprites/watermelon_sprite.tres")
}

const food_item_scene = preload("res://FarmScene/Food/FoodItem.tscn")

# animals

const animal_sprites = {
	Animal.AnimalType.Sheep: preload("res://Assets/Animals/Sheep/sheep-spritesheet.tres"),
	Animal.AnimalType.Dino: preload("res://Assets/Animals/Dino/dino-spritesheet.tres"),
	Animal.AnimalType.Turtle: preload("res://Assets/Animals/Turtle/turtle-spritesheet.tres")
}

# trees

const tree_scene = preload("res://FarmScene/FruitTrees/tree.tscn")

# sounds

const poop_sound = preload("res://Assets/Sound/DinosAndPoop/SFX_DinoPoop.wav")
const eat_sound = preload("res://Assets/Sound/DinosAndPoop/SFX_Eat_Crunch.wav")

#tower

const tower_scene = preload("res://TowerScene/tower.tscn")
