extends Node2D

@onready var game_customization: Node2D = $"../GameCustomization"


func _ready() -> void:
	pass # Replace with function body.

func _on_play_pressed() -> void:
	self.hide()
	game_customization.show()
	pass # Replace with function body.

func _on_instructions_pressed() -> void:
	self.hide()
	#load instructions page
	pass # Replace with function body.

func _on_exit_game_pressed() -> void:
	get_tree().quit()
