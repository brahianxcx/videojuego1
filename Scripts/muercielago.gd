extends CharacterBody2D



@export var frames : SpriteFrames
@export var move_speed = 300
@export var move_dir : Vector2


@export var detection_radius : float = 1500 # Distancia corta para que no se activen solas
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
var activo : bool = false
func _ready() -> void:
	if frames:
		anim.sprite_frames = frames
	anim.play("default")
	

func _actualizar_orientacion() -> void:
	if move_dir.x > 0:
		anim.flip_h = false
	elif move_dir.x < 0:
		anim.flip_h = true
func _physics_process(_delta: float) -> void:
	if activo:
		velocity = move_dir.normalized() * move_speed
		move_and_slide()
	else:
		_buscar_heroe_real()

func _buscar_heroe_real() -> void:
	var nodos_hero = get_tree().get_nodes_in_group("hero")
	
	for nodo in nodos_hero:
	
		if nodo == self or "muercielago" in nodo.name.to_lower():
			continue
			
		if nodo is Node2D:
			var distancia = global_position.distance_to(nodo.global_position)
			if distancia < detection_radius:
				activo = true
				_actualizar_orientacion()
				return
				

func die():
	
	set_physics_process(false) 
	
	var t = create_tween()
	t.tween_property(self, "scale", Vector2(1.5, 0.2), 0.1) # Se aplasta
	t.tween_property(self, "modulate:a", 0, 0.2) # Se desvanece
	await t.finished
	queue_free()







func _on_hit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero"):
		body.hurt(global_position)
