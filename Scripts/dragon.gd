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
		
	if not is_hurt:
		if Input.is_action_just_pressed("ui_up"):
			Sounds.play("jump")
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
		Sounds.play("muerte")
		Globals.set_lives(Globals.lives - 1)
		
	var vy_before = velocity.y
	move_and_slide()
	check_enemy(vy_before)
	
func check_enemy(vy_before):
	if is_hurt:
		return

	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		var e = c.get_collider()
		if e.is_in_group("enemies"):
			var n = c.get_normal()
			
			if (vy_before > stomp_down) and (n.y < -0.6):
				e.die()
				velocity.y = -stomp_bounce
				break
			else:
				hurt(c.get_position())
				break
				
func hurt(hit_pos):
	Sounds.play("hurt")
	is_hurt = true
	
	Globals.set_health(Globals.health - 1)
	if Globals.health <= 0:
		Sounds.play("muerte")
	
	var dir = sign(global_position.x - hit_pos.x)
	velocity = Vector2(250*dir, -220)

	var tween = create_tween()
	tween.set_loops(4) 
	tween.tween_property(anim, "modulate:a", 0.0, 0.05)
	tween.tween_property(anim, "modulate:a", 1.0, 0.05)
	
	await get_tree().create_timer(float(250)/1000, true).timeout
	is_hurt = false  
	anim.modulate.a = 1.0

func add_score(amount):
	Sounds.play("coin")
	Globals.add_score(amount)

func add_gemas(amount):
	Sounds.play("gem")
	Globals.add_gemas(amount)
