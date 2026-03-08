extends CharacterBody2D
@export var move_speed = 300
@export var move_dir : Vector2

var start_pos : Vector2
var target_pos : Vector2

func _ready() -> void:
	start_pos = global_position
	target_pos = start_pos + move_dir
	
func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	if global_position == target_pos:
		if global_position == start_pos:
			target_pos = start_pos + move_dir
		else :
			target_pos = start_pos
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		body.game_over()
