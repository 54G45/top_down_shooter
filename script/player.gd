extends CharacterBody2D
class_name Jogador

@export var bullet_scene : PackedScene
@export var shoot_cooldown : float = 0.1
var can_shoot : bool = true

var move_speed := 300.0
var move_direction := Vector2.ZERO

func _ready() -> void:
	Global.player = self

func _physics_process(delta: float) -> void:
	move_direction = Input.get_vector("mover_esquerda", "mover_direita", "mover_cima", "mover_baixo")
	velocity = move_direction * move_speed
	move_and_slide()
	
	var mouse_dir =  get_global_mouse_position() - global_position
	if Input.is_action_just_pressed("shoot") and can_shoot:
		_shoot(mouse_dir)

func _shoot(direction):
	can_shoot = false
	
	var bullet_instance = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.set_direction(direction)
	
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true
