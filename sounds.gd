extends Node

const SFX_BUS := "SFX"

const SFX_COIN : AudioStream = preload("res://Assets/sounds/sfx_coin.ogg")
const SFX_JUMP : AudioStream = preload("res://Assets/sounds/sfx_jump.ogg")
const SFX_HURT : AudioStream = preload("res://Assets/sounds/sfx_hurt.ogg")
const SFX_GEM : AudioStream = preload("res://Assets/sounds/sfx_gem.ogg")

var player : AudioStreamPlayer

func _ready() -> void:
	player = AudioStreamPlayer.new()
	player.bus = SFX_BUS
	add_child(player)
	
func play(name: String) -> void:
	match name: 
		"coin":
			player.stream = SFX_COIN
		"jump":
			player.stream = SFX_JUMP
		"hurt":
			player.stream = SFX_HURT
		"gem":
			player.stream = SFX_GEM
				
				
		_:
			return
	player.stop()
	player.play()
