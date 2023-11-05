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

func set_highlight_active(value):
	highlight_active = value
	tile_highlight.visible = value
