extends CharacterBody2D

@export var velocidad : float = 400.0
@export var distancia_maxima : float = 600.0

var dir : int = -1
var distancia_recorrida : float = 0.0


func _process(delta: float) -> void:
	
	var movimiento = velocidad * dir * delta
	position.x += movimiento
	
	
	distancia_recorrida += abs(movimiento)
	
	if distancia_recorrida >= distancia_maxima:
		queue_free()

func _on_body_entered(body: Node2D) -> void:

	if body.is_in_group("hero"):
		if body.has_method("hurt"):
			body.hurt()
		queue_free()
	
	
	if body is TileMap or body is StaticBody2D:
		queue_free()
