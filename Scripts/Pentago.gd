extends Node2D

@onready var main_menu: Node2D = $MainMenu
@onready var game_customization: Node2D = $GameCustomization

const BLOCK = preload("res://Scenes/GamePieces/Block.tscn")
const screen_size: Vector2 = Vector2(1152, 648)
@onready var winner_label: Label = $WinnerLabel


func _ready() -> void:
	SignalBus.end_game.connect(_end_game)
	SignalBus.start_game.connect(_start_game)

func _start_game() -> void:
	main_menu.hide()
	game_customization.hide()
	GameManager.CurrentPlayer = GameManager.PlayerOrder[0]
	create_blocks()

#creates a grid of blocks, each which contain 9 spaces
func create_blocks() -> void:
	for i in range(GameManager.BlockRows):
		for j in range(GameManager.BlockColumns):
			var instance = BLOCK.instantiate()
			instance.position = Vector2(j * (576.0/GameManager.BlockColumns) + (screen_size.x/2) - 288, i * (576.0/GameManager.BlockRows) + (screen_size.y/2) - 288)
			instance.block_coordinate = (i+1) * 10 + (j+1)
			print(Vector2(2.0/GameManager.BlockRows, 2.0/GameManager.BlockColumns))
			instance.scale = Vector2(2.0/GameManager.BlockRows, 2.0/GameManager.BlockColumns)
			add_child(instance)

#shows the winner message once the game ends
func _end_game(message) -> void:
	winner_label.text = message
	
#add reset function that clears all blocks from memory, then takes user back to main menu
