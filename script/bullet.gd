extends Area2D

@export var speed : float = 500.0
var direction : Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	position += direction.rotated(rotation) * speed * delta

func set_direction(new_direction):
	direction = new_direction.normalized()
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.take_damage(1, global_position)
		self.queue_free()
