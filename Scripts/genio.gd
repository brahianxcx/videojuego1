extends CharacterBody2D

@export var move_speed = 300
@export var move_dir : Vector2
@export var detection_radius : float = 2500 # Distancia corta para que no se activen solas
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
var activo : bool = false
func _ready() -> void:
	anim.play("default")
func _physics_process(_delta: float) -> void:
	if activo:
		velocity = move_dir.normalized() * move_speed
		move_and_slide()
	else:
		_buscar_heroe_real()

func _buscar_heroe_real() -> void:
	var nodos_hero = get_tree().get_nodes_in_group("hero")
	
	for nodo in nodos_hero:
		
	
		if nodo is Node2D:
			var distancia = global_position.distance_to(nodo.global_position)
			if distancia < detection_radius:
				activo = true
				return



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero") and body.has_method("game_over"):
		body.game_over()
