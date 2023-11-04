extends Node

var parent: Node2D

func _ready():
	var p = get_parent()
	if (p is Node2D):
		parent = p

func _input(event):
	if (!parent):
		return
	
	if event is InputEventMouseMotion:
		var mousePos = event.position
		parent.position = mousePos
