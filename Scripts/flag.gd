extends Area2D

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@export_file("*.tscn") var next_scene

func _ready() -> void:
	anim.play("default")



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		get_tree().change_scene_to_file(next_scene)
