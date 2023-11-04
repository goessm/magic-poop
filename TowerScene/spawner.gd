class_name Spawner
extends Node

#var enemy_scene: PackedScene = preload("res://TowerScene/Entities/enemy.tscn")
@export var timer: Timer
@export var spawn_points: Node
@export var enemy_types: Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_scene: PackedScene = preload("res://TowerScene/Entities/enemy.tscn")
	enemy_types.push_back(enemy_scene)
	timer.timeout.connect(_on_timeout)
	timer.one_shot = true
	timer.start(2.5)

func init(_enemy_types: Array):
	enemy_types = _enemy_types
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_timer(time_sec: float):
	timer.start(time_sec)

func spawn_enemy():
	if enemy_types.is_empty():
		print("cant spawn: no enemy types defined")
		return
	var enemy_type = enemy_types.pick_random()
	var spawn_points_arr = spawn_points.get_children()
	if spawn_points_arr.is_empty():
		print("cant spawn: no spawn points defined")
		return
	var spawn_point = spawn_points_arr.pick_random()
	var ins = enemy_type.instantiate()
	ins.position = spawn_point.position
	add_child(ins)

func _on_timeout():
	spawn_enemy()
	timer.start(10.0)
	pass
