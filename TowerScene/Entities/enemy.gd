class_name Enemy
extends CharacterBody2D

@export var health: Health
@export var path_follow: PathFollow2D
@export var sprite: Sprite2D
@export var health_bar: ProgressBar
@export var attack_strength: int = 6
@export var speed: float = 80.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer = $AttackTimer

enum ANIM_STATE {RUNNING, BITING}

var _anim_state = ANIM_STATE.RUNNING
var _bite_anim_time: float = 0.8 # depends on animated_sprite_2d
var _attack_target = null

var max_health = 100

signal died(obj)


# returns true if state was changed, false if state was already new_state
func change_anim_state(new_state):
	if new_state == _anim_state:
		return false
	_anim_state = new_state
	return true


# Called when the node enters the scene tree for the first time.
func _ready():
	health.init(max_health)
	health.health_changed.connect(_on_health_changed)
	position = path_follow.position
	# sprite animation must be in sync with animState
	animated_sprite_2d.play("bite")
	change_anim_state(ANIM_STATE.BITING)
	
	attack_timer.timeout.connect(attack)
	attack_timer.one_shot = true
	
	Music.play_combat()


# checks colliding objects and deals damage
func attack():
	var num_collisions = get_slide_collision_count()
	for i in range(num_collisions):
		var coll = get_slide_collision(i)
		var obj = coll.get_collider()
		if obj && obj.has_method("take_damage_from_enemy"):
			obj.take_damage_from_enemy(attack_strength)
			break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _attack_target != null && _attack_target.is_dead():
		_attack_target = null
	if _attack_target == null:
		var targets = get_tree().get_nodes_in_group(Groups.Animals)
		if targets.is_empty():
			# set idle anim (jk its the run anim)
			if change_anim_state(ANIM_STATE.RUNNING):
				animated_sprite_2d.play("run")
			return
		# select new target
		_attack_target = targets.pick_random()
	hunt_update(delta, _attack_target)


# tries to move toward target and attacks if colliding
func hunt_update(delta, target: Node2D):
	var target_pos := target.position
	var diff_vec = target_pos - position
	var dist := diff_vec.length()
	#move toward target
	var last_pos = position
	velocity = speed * diff_vec.normalized()
	animated_sprite_2d.flip_h = velocity.x < 0
	var colliding = move_and_slide()
	var num_collisions = get_slide_collision_count()
	var colliding_with_prey = false
	for i in range(num_collisions):
		var coll = get_slide_collision(i)
		var obj = coll.get_collider()
		if obj.has_method("take_damage_from_enemy") && attack_timer.is_stopped():
			attack_timer.start(_bite_anim_time)
			colliding_with_prey = true
			print("Started attack timer")
			break
	if colliding_with_prey: # TODO add attack distance?
		# do damage to animal and start animation
		if change_anim_state(ANIM_STATE.BITING):
			animated_sprite_2d.play("bite")
	else:
		if !animated_sprite_2d.is_playing():
			if change_anim_state(ANIM_STATE.RUNNING):
				animated_sprite_2d.play("run")
	pass


# called when gets hit by projectile
func hit(projectile: Projectile, damage: int):
	health.takeDamage(damage)


func is_dead() -> bool:
	return health.health <= 0


func _on_health_changed(obj, val):
	#print("_on_health_changed ", obj, val, ", ", health.max_health)
	health_bar.set_value_no_signal(100 * val / health.max_health)
	if val <= 0:
		remove_from_group(Groups.Enemies)
		emit_signal("died", self)
		queue_free()

func _on_animation_finished():
	print("anim finished")
