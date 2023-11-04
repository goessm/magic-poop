class_name Tower
extends Node2D

@export var shoot_cooldown: float
var time_since_shot: float

# Called when the node enters the scene tree for the first time.
func _ready():
	shoot_cooldown = 2.0
	time_since_shot = shoot_cooldown


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_since_shot = min(time_since_shot + delta, shoot_cooldown)
	if time_since_shot >= shoot_cooldown:
		# get enemy and shoot
		var enemies = get_tree().get_nodes_in_group(Groups.Enemies)
		if enemies.is_empty():
			return
		var target = enemies.pick_random()
		# spawn projectile
		var projectile_scene: PackedScene = preload("res://TowerScene/Entities/projectile.tscn")
		var projectile = projectile_scene.instantiate()
		#projectile.position = position
		var direction: Vector2 = target.position - position
		projectile.direction = direction.normalized()
		time_since_shot = 0.0
		add_child(projectile)
	pass
