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

const animal_sprites = {
	Animal.AnimalType.Sheep: preload("res://Assets/Animals/Sheep/sheep-spritesheet.tres"),
	Animal.AnimalType.Dino: preload("res://Assets/Animals/Dino/dino-spritesheet.tres"),
	Animal.AnimalType.Turtle: preload("res://Assets/Animals/Turtle/turtle-spritesheet.tres")
}
