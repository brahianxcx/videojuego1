extends CharacterBody2D

var speed = 200
var jump_force = 350
var gravity = 1000
var stomp_down = 120
var stomp_bounce = 250
var is_hurt = false



@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	anim.play("idle")

	
	
	
	
	
func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
		
	if not  is_hurt:
		if Input.is_action_pressed("ui_up"):
			direction.y = -1
		 
		if Input.is_action_pressed("ui_left"):
			direction.x = -1
			
			anim.flip_h = true
			
			
		elif Input.is_action_pressed("ui_right"):
			direction.x = 1
			
			anim.flip_h = false
			
			
			
		velocity.x = direction.x * speed
		
		if is_on_floor() and direction.y == -1:
			velocity.y = direction.y * jump_force
	
	if not is_on_floor():
		
		anim.play("jump")
	else:
		
		if velocity.x != 0:
			anim.play("walk")
		else:
			anim.play("idle")

	move_and_slide()
	
	
	
	
	if global_position.y > 20000:
		game_over()
		
	var vy_before = velocity.y
	move_and_slide()
	check_enemy(vy_before)
	
	
	
func check_enemy(vy_before):
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		var e = c.get_collider()
		if e.is_in_group("enemies"):
			var n = c.get_normal()
			 
			if  (vy_before > stomp_down) and (n.y < -0.6):
				e.die()
				velocity.y = -stomp_bounce
				break
			else:
				hurt(c.get_position())
				break
				
func hurt(hit_pos):
	
	var dir = sign(global_position.x - hit_pos.x)
	velocity = Vector2(250*dir, -220)
	is_hurt = true
	Globals.lives -= 1
	print(Globals.lives)
	
	await get_tree().create_timer(float(250)/1000, true).timeout
	is_hurt = false  
			
	
	

func game_over():
	get_tree().reload_current_scene()
	
func add_score(amount):
	Globals.add_score(amount)

func add_gemas(amount):
	Globals.add_gemas(amount)
