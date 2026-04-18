extends CharacterBody2D

# --- CONFIGURACIÓN DEL BOSS ---
@export var move_dir : Vector2
@export var speed = 120
@export var gravity = 900
@export var move_speed = 100
@export var proyectil_escena : PackedScene 

var start_pos : Vector2
var target_pos : Vector2

var dir = 1

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer = $AttackTimer

func _ready() -> void:
	dir = -1             # Obligamos a que empiece hacia la izquierda
	start_pos = global_position
	target_pos = start_pos + move_dir
	anim.play("idle")

func _physics_process(delta: float) -> void:

	global_position = global_position.move_toward(target_pos, move_speed * delta)
	
	
	if global_position == target_pos:
		if target_pos == start_pos:
			target_pos = start_pos + move_dir
			dir = -1 
		else:
			target_pos = start_pos
			dir = 1  
		
		
		anim.flip_h = (dir > 0)
	
	move_and_slide()


func _on_timer_timeout() -> void:
	if dir == -1: 
		_lanzar_ataque()
	else:
		
		print("No disparo porque estoy mirando a la derecha")

func _lanzar_ataque():
	velocity.x = 0
	anim.play("attack_1")
	await get_tree().create_timer(0.5).timeout
	
	if proyectil_escena:
		var bala = proyectil_escena.instantiate()
		bala.global_position = $SpawnPunto.global_position
		if bala.has_method("set_direction"):
			bala.set_direction(dir)
		get_parent().add_child(bala)
	



func _on_debilidad_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		body.hurt(global_position)
		Globals.set_health(Globals.health-1)



func die():
	
	set_physics_process(false) 
	
	var t = create_tween()
	t.tween_property(self, "scale", Vector2(1.5, 0.2), 0.1) 
	t.tween_property(self, "modulate:a", 0, 0.2) 
	await t.finished
	queue_free()
