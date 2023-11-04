class_name Enemy
extends CharacterBody2D

signal died(obj)

@export var health: Health
@export var path_follow: PathFollow2D
@export var sprite: Sprite2D
@export var health_bar: ProgressBar
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer = $AttackTimer

enum ANIM_STATE {RUNNING, BITING}

var _dead = false
var _anim_state = ANIM_STATE.RUNNING
var attack_dist: float = 10.0
var speed: float = 200.0
var bite_anim_time: float = 0.8
var attack_strength: int = 20

func change_anim_state(new_state):
	if new_state == _anim_state:
		return false
	_anim_state = new_state
	return true

# Called when the node enters the scene tree for the first time.
func _ready():
	health.init(100)
	health.health_changed.connect(_on_health_changed)
	position = path_follow.position
	animated_sprite_2d.play("run")
	attack_timer.timeout.connect(attack)
	attack_timer.one_shot = true

func attack():
	var num_collisions = get_slide_collision_count()
	for i in range(num_collisions):
		var coll = get_slide_collision(i)
		var obj = coll.get_collider()
		if obj.has_method("take_damage_from_enemy"):
			obj.take_damage_from_enemy(attack_strength)
			break

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var targets = get_tree().get_nodes_in_group(Groups.Animals)
	if targets.is_empty():
		return # TODO do something else?
	var target = targets.pick_random()
	hunt_update(delta, target)

func hunt_update(delta, target: Node2D):
	var target_pos := target.position
	var diff_vec = target_pos - position
	var dist := diff_vec.length()
	
	#move toward target
	velocity = speed * diff_vec.normalized()
	var colliding = move_and_slide()
	var num_collisions = get_slide_collision_count()
	for i in range(num_collisions):
		var coll = get_slide_collision(i)
		var obj = coll.get_collider()
		if obj.has_method("take_damage_from_enemy") && attack_timer.is_stopped():
			attack_timer.start(bite_anim_time)
	
	if colliding: # TODO add attack distance?
		# do damage to animal
		# try start anim
		if change_anim_state(ANIM_STATE.BITING):
			animated_sprite_2d.play("bite")
	else:
		if change_anim_state(ANIM_STATE.RUNNING):
			animated_sprite_2d.play("run")
	pass

func hit(projectile: Projectile, damage: int):
	health.takeDamage(damage)

func _on_health_changed(obj, val):
	#print("_on_health_changed ", obj, val, ", ", health.max_health)
	health_bar.set_value_no_signal(100 * val / health.max_health)
	if val <= 0:
		_dead = true
		emit_signal("died", self)
		queue_free()
