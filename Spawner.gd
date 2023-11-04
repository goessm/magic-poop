extends Node

var enemy_scene = preload("res://enemy.tscn")
@export var timer: Timer
@export var spawn_points: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.timeout.connect(_on_timeout)
	timer.start(2.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy():
	var ins = enemy_scene.instantiate()
	var spawn_points_arr = spawn_points.get_children()
	var n = spawn_points_arr.size()
	var spawn_point = spawn_points_arr[randi() % n]
	ins.position = spawn_point.position
	add_child(ins)

func _on_timeout():
	spawn_enemy()
