extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		Globals.set_lives(Globals.lives - 1)
