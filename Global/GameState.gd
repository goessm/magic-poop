extends Node

signal gamestate_change

var held_poop: Poop.PoopType

var tree_positions: Array[Vector2] = []

func set_held_poop(poop_type: Poop.PoopType):
	held_poop = poop_type
	gamestate_change.emit()
