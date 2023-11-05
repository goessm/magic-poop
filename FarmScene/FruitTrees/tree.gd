extends StaticBody2D

enum GrowthStage {
	Seed,
	Growing,
	Grown
}

@export var fruit_type: FoodItem.FoodType
@export var fruit_parent: NodePath

@onready var animated_sprite = $AnimatedSprite2D
@onready var health = $Health
@onready var health_bar = $ProgressBar

@export var shoot_cooldown: float
@export var ammo: int
@export var infinite_ammo: bool

var fruit: FoodItem
var fruitScene: PackedScene

var _time_since_shot: float
var is_tower: bool = false

var stage: GrowthStage = GrowthStage.Seed

func _ready():
	health.init(100)
	health.health_changed.connect(_on_health_changed)
	_update_growing_sprite()
	shoot_cooldown = 0.1
	_time_since_shot = shoot_cooldown
	ammo = 100
	
	#transform_into_a_tower()

func drop_fruit():
	animated_sprite.play("drop_fruit")
	animated_sprite.play()
	animated_sprite.animation_finished.connect(_on_fruitdrop_animation_finished)

func spawn_fruit():
	if (fruit):
		# old fruit still exists, don't spawn
		return
	
	var spawned_fruit: FoodItem = SceneList.food_item_scene.instantiate()
	spawned_fruit.type = fruit_type
	get_node(fruit_parent).add_child(spawned_fruit)
	fruit = spawned_fruit


func _on_grow_timer_timeout():
	#print("grow timer")
	if (stage == GrowthStage.Grown):
		spawn_fruit()
	else:
		grow_tree()

func grow_tree():
	stage = stage + 1
	_update_growing_sprite()

func _update_growing_sprite():
	if (stage == GrowthStage.Grown):
		animated_sprite.play("default")
		return
	
	# grow stage sprites
	var frame = 1
	
	match (stage):
		GrowthStage.Seed:
			frame = 1
		GrowthStage.Growing:
			frame = 2
	
	animated_sprite.play("grow")
	animated_sprite.pause()
	animated_sprite.frame = frame

func _on_fruitdrop_animation_finished():
	animated_sprite.animation_finished.disconnect(_on_fruitdrop_animation_finished)
	spawn_fruit()


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

func transform_into_a_tower():
	print("transforming")
	animated_sprite.play("tower_attack")
	animated_sprite.pause()
	is_tower = true


func _process(delta):
	if !is_tower:
		return
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


func _on_input_event(viewport, event, shape_idx):
	pass


func _on_click_area_input_event(viewport, event, shape_idx):
	if (is_tower):
		print("is tower: cant transform anymore")
		return
	
	if (stage != GrowthStage.Grown):
		return
	
	if (event is InputEventMouseButton and event.pressed):
		print("clicked on tower")
		if (GameState.held_poop != Poop.PoopType.Default && Inventory.get_poops(GameState.held_poop) > 0):
				print("transforming")
				Inventory.add_poop(GameState.held_poop, -1)
				transform_into_a_tower()
				GameState.held_poop = Poop.PoopType.Default
				pass
