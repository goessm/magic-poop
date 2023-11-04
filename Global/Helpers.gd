extends Node



static func get_collision_shape_height(obj) -> float:
	var shape = obj.get_node("CollisionShape2D").shape
	if "size" in shape: # assume Rectangle
		return shape.size.y
	else:
		return shape.radius * 2


static func get_collision_shape_width(obj) -> float:
	var shape = obj.get_node("CollisionShape2D").shape
	if "size" in shape: # assume Rectangle
		return shape.size.x
	else:
		return shape.radius * 2
