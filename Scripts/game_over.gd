extends Control
@onready var button: Button = $Button




func _on_button_pressed() -> void:
	Globals.new_game()
