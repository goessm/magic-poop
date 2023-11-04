extends Node

# poops
const normal_poop = preload("res://FarmScene/Poop/Poop.tscn")

const animal_poops = {
	Animal.AnimalType.Sheep: normal_poop,
	Animal.AnimalType.Dino: normal_poop,
	Animal.AnimalType.Turtle: normal_poop
}

const animal_sprites = {
	Animal.AnimalType.Sheep: preload("res://Assets/Animals/Sheep/sheep-spritesheet.tres"),
	Animal.AnimalType.Dino: preload("res://Assets/Animals/Dino/dino-spritesheet.tres"),
	Animal.AnimalType.Turtle: preload("res://Assets/Animals/Turtle/turtle-spritesheet.tres")
}
