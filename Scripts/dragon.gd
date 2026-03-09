extends CharacterBody2D

var speed = 280
var jump_force = 450
var gravity = 1000
var score = 0
var gemas = 0

@onready var score_text : Label = get_node("CanvasLayer/HBoxContainer/Label")
@onready var gem_text : Label = get_node("CanvasLayer/HBoxContainer/Label2")

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
	
	if global_position.y > 1500:
		game_over()
		
	move_and_slide()
	
func game_over():
	get_tree().reload_current_scene()
	
func  add_score(amount):
	score+= amount
	score_text.text = str(score)
	
	print(score)
	
func add_gemas(amount):
	gemas += amount
	gem_text.text = str(gemas)
