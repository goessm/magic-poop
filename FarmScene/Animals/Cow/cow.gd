class_name Cow

extends Node2D

var allow_to_be_moved := true

func move(direction: Vector2):
	position += direction
