extends Area2D

@export var skin: Texture2D
@export var custom_scale: Vector2 = Vector2(1,1)
func _ready() -> void:
	if skin and $Sprite2D:
		$Sprite2D.texture = skin
		scale=custom_scale

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		body.game_over()
	
