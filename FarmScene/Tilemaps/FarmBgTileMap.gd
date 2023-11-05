extends TileMap

@onready var tile_highlight = $TileHighlight
@export var highlight_active: bool = true : set = set_highlight_active
var highlighted_tile:Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if highlight_active:
			highlighted_tile = local_to_map(get_local_mouse_position())
			tile_highlight.position = map_to_local(highlighted_tile)
	elif event is InputEventMouseButton:
		if event.button_mask & 1 and event.pressed:
			print(event)
			if (GameState.held_poop != Poop.PoopType.Default && Inventory.get_poops(GameState.held_poop) > 0):
				Inventory.add_poop(GameState.held_poop, -1)
				spawn_tree(tile_highlight.position)
				pass

func set_highlight_active(value):
	highlight_active = value
	tile_highlight.visible = value

func spawn_tree(pos):
	var tree = SceneList.tree_scene.instantiate()
	get_parent().get_node("Trees").add_child(tree)
	tree.position = pos
