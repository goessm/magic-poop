extends TileMap

@onready var tile_highlight = $TileHighlight
@export var highlight_active: bool = true : set = set_highlight_active
var highlighted_tile:Vector2i
var planted_trees : Array[Vector2] =  []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func tree_is_near(tilepos):
	var trees = get_tree().get_nodes_in_group("Tree")
	
	for i in range(trees.size()):
		var treepos = trees[i].global_position
		var v = tilepos - treepos
		var dist = v.length()
		print("dist" + str(dist))
		if (dist < 40.0):
			return true
	return false
		

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if highlight_active:
			highlighted_tile = local_to_map(get_local_mouse_position())
			tile_highlight.position = map_to_local(highlighted_tile)
	elif event is InputEventMouseButton:
		if event.button_mask & 1 and event.pressed:
			if tree_is_near(get_global_mouse_position()):
				return
			#if (GameState.tree_positions.has(highlighted_tile)):
			#	return
			print(event)
			print("clicked on tile")
			#if (there_is_a_tree_close_to())
			if (GameState.held_poop != Poop.PoopType.Default && Inventory.get_poops(GameState.held_poop) > 0):
				Inventory.add_poop(GameState.held_poop, -1)
				spawn_tree(tile_highlight.position)
				#GameState.held_poop = Poop.PoopType.Default
				planted_trees.push_back(highlighted_tile)
				#GameState.tree_positions.push_back(highlighted_tile)
				pass

func set_highlight_active(value):
	highlight_active = value
	tile_highlight.visible = value

func spawn_tree(pos):
	var tree = SceneList.tree_scene.instantiate()
	get_parent().get_node("Trees").add_child(tree)
	tree.position = pos


func _on_timer_timeout():
	pass # Replace with function body.
