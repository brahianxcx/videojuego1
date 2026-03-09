extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		body.add_gemas(1)
		queue_free()
