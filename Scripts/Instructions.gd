extends Node2D

@onready var main_menu: Node2D = $"../MainMenu"


func _ready() -> void:
	pass # Replace with function body.

func _on_button_pressed() -> void:
	self.hide()
	main_menu.show()
