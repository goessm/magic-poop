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


var fruit: FoodItem
var fruitScene: PackedScene

var stage: GrowthStage = GrowthStage.Seed

func _ready():
	health.init(100)
	health.health_changed.connect(_on_health_changed)
	_update_growing_sprite()

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
	print("grow timer")
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
