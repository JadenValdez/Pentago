extends Node2D

const SPACE = preload("res://Scenes/Space.tscn")

var board_array: Array = [
	["Empty", "Empty", "Empty"],
	["Empty", "Empty", "Empty"],
	["Empty", "Empty", "Empty"],
]

const COLORS: Dictionary = {
	"White": Color(1, 1, 1),
	"Black": Color(0, 0, 0),
	"Empty": Color(0.5, 0.5, 0.5)
}
var block_coordinate: int

func _ready() -> void:
	create_spaces()

func create_spaces() -> void:
	for x in range(3):
		for y in range(3):
			var instance = SPACE.instantiate()
			instance.space_coordinate = x * 10 + y
			instance.status = "Empty"
			instance.position = Vector2(x * 96 + 48, y * 96 + 48)
			add_child(instance)
