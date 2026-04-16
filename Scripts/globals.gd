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
	
	
