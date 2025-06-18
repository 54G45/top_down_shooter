extends CharacterBody2D
class_name Jogador

var move_speed := 300.0
var move_direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	move_direction = Input.get_vector("mover_esquerda", "mover_direita", "mover_cima", "mover_baixo")
	velocity = move_direction * move_speed
	move_and_slide()
