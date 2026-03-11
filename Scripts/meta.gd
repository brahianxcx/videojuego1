extends Node2D

func _on_meta_body_entered(body: Node2D) -> void:
	print("Colisión detectada con: ", body.name)
	
	# Usamos "personaje" que es el nombre que salió en tu consola
	if body.name == "personaje":
		print("¡Nombre correcto! Cambiando a escena...")
		get_tree().change_scene_to_file("res://Scenes/fin-nivel.tscn")
	else:
		print("El nombre no coincide con 'personaje'")
