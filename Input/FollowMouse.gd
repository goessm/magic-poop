class_name FollowMouse
extends Node

var parent: Node2D

var follow = true

func _ready():
	var p = get_parent()
	if (p is Node2D):
		parent = p

func _input(event):
	if (!follow):
		return
		
	if (!parent):
		return
	
	if event is InputEventMouseMotion:
		var mousePos = event.position
		parent.position = mousePos
