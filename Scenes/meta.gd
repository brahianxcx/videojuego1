extends Area2D

func _on_area_2d_3_body_entered(body: Node2D) -> void:
	# Verificamos si el que entró es tu personaje "Orig"
	if body.name == "Orig" or body.is_in_group("jugador"):
		print("¡Meta alcanzada!")
		
		# Cambiamos a la escena final
		# Asegúrate de que la ruta sea la correcta (puedes arrastrar el archivo aquí)
		get_tree().change_scene_to_file("res://fin-nivel.tscn")
	if body.name == "Orig": 
		print("¡Cambiando a escena final!")
		get_tree().change_scene_to_file("res://fin-nivel.tscn")
