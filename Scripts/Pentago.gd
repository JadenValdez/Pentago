extends Node2D

const BLOCK = preload("res://Scenes/GamePieces/Block.tscn")
const screen_size: Vector2 = Vector2(1152, 648)
@onready var winner_label: Label = $WinnerLabel


func _ready() -> void:
	SignalBus.end_game.connect(_end_game)
	start_game()

func start_game() -> void:
	create_blocks()

#creates a grid of blocks, each which contain 9 spaces
func create_blocks() -> void:
	for i in range(GameManager.BlockRows):
		for j in range(GameManager.BlockColumns):
			var instance = BLOCK.instantiate()
			instance.position = Vector2(j * 288 + (screen_size.x/2) - (GameManager.BlockColumns * 288)/2.0, i * 288 + (screen_size.y/2) - (GameManager.BlockRows * 288)/2.0)
			instance.block_coordinate = (i+1) * 10 + (j+1)
			instance.size = Vector2(1.0/GameManager.BlockRows, 1.0/GameManager.BlockColumns)
			add_child(instance)

#shows the winner message once the game ends
func _end_game(message) -> void:
	winner_label.text = message
