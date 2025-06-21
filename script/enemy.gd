extends CharacterBody2D

@onready var square:  Sprite2D = $square
@export var move_speed : float = 100.0
@export var health : int = 3

var direction : Vector2 = Vector2.ZERO
var player = null
var knockback_velocity: Vector2 = Vector2.ZERO
var knockback_decay: float = 800.0

func _ready() -> void:
	player = Global.player

func _physics_process(delta: float) -> void:
	if knockback_velocity.length() > 1:
		velocity = knockback_velocity
		move_and_slide()
		knockback_velocity =  knockback_velocity.move_toward(Vector2.ZERO, knockback_decay * delta)
	else:
		if player:
			direction = global_position.direction_to(player.global_position)
			velocity = direction * move_speed
	
	
	move_and_slide()

func apply_knockback(force: Vector2):
	knockback_velocity = force

func take_damage(amount: int, _source_position: Vector2):
	health -= amount
	var knockback_dir = (global_position - _source_position).normalized()
	apply_knockback(knockback_dir * 600)
	if health <= 0:
		queue_free()
	print("enemy health is: " + str(health))
