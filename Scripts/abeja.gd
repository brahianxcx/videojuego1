extends CharacterBody2D

@export var move_speed = 300
@export var move_dir : Vector2
@export var detection_radius : float = 1500 # Distancia corta para que no se activen solas

var activo : bool = false

func _physics_process(_delta: float) -> void:
	if activo:
		velocity = move_dir.normalized() * move_speed
		move_and_slide()
	else:
		_buscar_heroe_real()

func _buscar_heroe_real() -> void:
	var nodos_hero = get_tree().get_nodes_in_group("hero")
	
	for nodo in nodos_hero:
		# FILTRO: Ignora si el nodo es una abeja o si es ella misma
		if nodo == self or "abeja" in nodo.name.to_lower():
			continue
			
		if nodo is Node2D:
			var distancia = global_position.distance_to(nodo.global_position)
			if distancia < detection_radius:
				activo = true
				return

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("hero") and body.has_method("game_over"):
		body.game_over()
