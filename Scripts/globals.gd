extends Node2D


var lives_max = 3
var health_max = 5
var score = 0
var gemas = 0
var lives = lives_max
var health = health_max

signal gemas_changed
signal score_changed
signal lives_changed
signal health_changed

func add_gemas(n):
	gemas+= n
	gemas_changed.emit(gemas)
func add_score(n):
	score += n
	score_changed.emit(score)
	
func set_health(n):
	health =clamp(n, 0, health_max)
	health_changed.emit(health)
	if health == 0:
		set_lives(lives-1)
	
	
func set_lives(n):
	lives = max(0, n)
	lives_changed.emit(lives)
	if lives == 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	else:
		score = 0
		gemas = 0
		health = health_max
		score_changed.emit(score)
		gemas_changed.emit(gemas)
		get_tree().reload_current_scene()
	

func new_game():
	score = 0
	gemas = 0
	lives = lives_max
	health = health_max
	score_changed.emit(score)
	gemas_changed.emit(gemas)
	health_changed.emit(health)
	lives_changed.emit(lives)
	get_tree().change_scene_to_file("res://Scenes/videojuego1.tscn")
	
	
