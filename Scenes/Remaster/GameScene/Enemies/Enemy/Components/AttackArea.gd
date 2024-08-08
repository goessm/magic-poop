extends Area2D

signal attacking

@export var is_attacking: bool
@export var attack_strength := 10

@export_group("Dependencies")
@export var sprite: AnimatedSprite2D
@export var speed_sensor: SpeedSensor

@export_group("Components")
@export var collision_shape: CollisionShape2D
@export var attack_timer: Timer
@export var standstill_timer: Timer

const min_speed = 0.06

func set_attacking(state: bool):
	is_attacking = state
	
	if is_attacking:
		if (attack_timer.is_stopped()):
			attack_timer.start()
	
	if !is_attacking:
		attack_timer.stop()
		if (sprite.animation == "attack"):
			sprite.play("run")

func _on_attack_timer_timeout() -> void:
	if (is_attacking):
		attack()

func attack():
	print("trying to attack")
	var targets = get_overlapping_bodies()
	var chosen_target: Node2D = null
	for target in targets:
		if target.has_method("take_damage_from_enemy"):
			chosen_target = target
			break
	
	if !chosen_target:
		sprite.play("run")
		return
	
	print("ATTACKING")
	chosen_target.take_damage_from_enemy(attack_strength)
	sprite.play("attack")

func _physics_process(delta: float) -> void:
	if (speed_sensor.get_speed() >= min_speed):
		standstill_timer.stop()
		set_attacking(false)
	else:
		if (standstill_timer.is_stopped()):
			standstill_timer.start()

func _on_standstill_timer_timeout() -> void:
	print("STANDSTILL TIMER")
	set_attacking(true) # attack when standing still too long
