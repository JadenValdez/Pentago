extends Node2D

const BLOCK = preload("res://Scenes/Block.tscn")
const screen_size = Vector2(1152, 648)

var rows = 2
var columns = 2


func _ready() -> void:
	create_blocks()

func create_blocks() -> void:
	for i in range(rows):
		for j in range(columns):
			var instance = BLOCK.instantiate()
			instance.position = Vector2(j * 288 + (screen_size.x/2) - (columns * 288)/2.0, i * 288 + (screen_size.y/2) - (rows * 288)/2.0)
			instance.block_coordinate = i * 10 + j
			add_child(instance)
