extends CanvasLayer

@export var heart_full: Texture2D
@export var heart_empty: Texture2D

@onready var score_icon: TextureRect = $Control/TOP/ScoreBox/ScoreIcon
@onready var score_label: Label = $Control/TOP/ScoreBox/ScoreLabel
@onready var gems_icon: TextureRect = $Control/TOP/GemsBox/GemsIcon
@onready var gems_label: Label = $Control/TOP/GemsBox/GemsLabel
@onready var lives_icon: TextureRect = $Control/TOP/LivesBox/LivesIcon
@onready var lives_label: Label = $Control/TOP/LivesBox/LivesLabel
@onready var heart_box: HBoxContainer = $Control/HeartBox

func _ready() -> void:
	update_score(Globals.score)
	update_lives(Globals.lives)
	build_hearts(Globals.health_max)
	update_hearts(Globals.health)
	update_gems(Globals.gemas)
	Globals.score_changed.connect(update_score)
	Globals.lives_changed.connect(update_lives)
	Globals.gemas_changed.connect(update_gems)
	Globals.health_changed.connect(update_hearts)
	
func update_score(n): 
	score_label.text = str(n)

func update_gems(n):
	gems_label.text = str(n)

func build_hearts(n):
	for i in range(n):
		var t:= TextureRect.new()
		t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		t.custom_minimum_size = Vector2(24,24)
		t.texture = heart_full
		heart_box.add_child(t)
		
	

func update_hearts(n):
	var i = 0
	for child in heart_box.get_children():
		if i < n:
			child.texture = heart_full
		else:
			child.texture = heart_empty
		i+=1
	pass
	
	
func update_lives(n) :
	lives_label.text = str(n)
