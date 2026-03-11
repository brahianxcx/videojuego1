extends Area2D

func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.name == "Orig" or body.is_in_group("jugador"):
		print("¡Meta alcanzada! Intentando cambiar escena...")
		
		# Cargamos la escena primero para verificar que existe
		var proxima_escena = load("res://Scenes/fin-nivel.tscn")
		
		if proxima_escena:
			get_tree().change_scene_to_packed(proxima_escena)
		else:
			print("ERROR: No se pudo encontrar el archivo en res://Scenes/fin-nivel.tscn")
