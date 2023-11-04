class_name Tower
extends Node2D

@export var shoot_cooldown: float
@export var ammo: int
@export var infinite_ammo: bool
@export var health_bar: ProgressBar
@onready var health: Health = $Health

var _time_since_shot: float


signal died(obj)


# Called when the node enters the scene tree for the first time.
func _ready():
	health.init(100)
	health.health_changed.connect(_on_health_changed)
	shoot_cooldown = 0.1
	_time_since_shot = shoot_cooldown
	ammo = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_time_since_shot = min(_time_since_shot + delta, shoot_cooldown)
	if ammo == 0 && !infinite_ammo:
		print("out of ammo")
		return
	if _time_since_shot >= shoot_cooldown:
		# get enemy and shoot
		var enemies = get_tree().get_nodes_in_group(Groups.Enemies)
		if enemies.is_empty():
			return
		# pick enemy to target: closest enemy
		var best_idx = -1
		var lowest_dist: float = INF
		for i in range(enemies.size()):
			var diff_vec = enemies[i].position - position
			var dist = diff_vec.length()
			if dist < lowest_dist:
				lowest_dist = dist
				best_idx = i
		#var target = enemies.pick_random()
		# spawn projectile
		var projectile_scene: PackedScene = preload("res://TowerScene/Entities/projectile.tscn")
		var projectile = projectile_scene.instantiate()
		#projectile.position = position
		var direction: Vector2 = enemies[best_idx].position - position
		projectile.direction = direction.normalized()
		_time_since_shot = 0.0
		if !infinite_ammo:
			ammo -= 1
		add_child(projectile)
	pass


func is_dead() -> bool:
	return health.health <= 0


func take_damage_from_enemy(amount: int):
	var hit_particle_scene: PackedScene = preload("res://TowerScene/Entities/hit_particle.tscn")
	var particle = hit_particle_scene.instantiate()
	add_child(particle)
	health.takeDamage(amount)


func _on_health_changed(obj, val):
	#print("_on_health_changed ", obj, val, ", ", health.max_health)
	health_bar.set_value_no_signal(100 * val / health.max_health)
	if val <= 0:
		emit_signal("died", self)
		queue_free()
