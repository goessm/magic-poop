class_name FollowMouse
extends Node

var parent: Node2D

var follow = false

func _ready():
	var p = get_parent()
	if (p is Node2D):
		parent = p

func _process(delta):
	if (!follow):
		return
		
	if (!parent):
		return
	
	parent.position = parent.get_global_mouse_position()

