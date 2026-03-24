extends Node2D

@onready var game_customization: Node2D = $"../GameCustomization"
@onready var instructions: Node2D = $"../Instructions"


func _ready() -> void:
	pass # Replace with function body.

func _on_play_pressed() -> void:
	self.hide()
	game_customization.show()

func _on_instructions_pressed() -> void:
	self.hide()
	instructions.show()

func _on_exit_game_pressed() -> void:
	get_tree().quit()
