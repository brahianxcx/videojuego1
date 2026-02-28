extends CharacterBody2D

var speed = 100
var jump_force = 400
var gravity = 500

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
		
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
		
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
		
	velocity.x = direction.x * speed
	
	if is_on_floor() and direction.y == -1:
		velocity.y = direction.y * jump_force
		
	move_and_slide()
