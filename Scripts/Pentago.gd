extends Node2D

@onready var main_menu: Node2D = $MainMenu
@onready var game_customization: Node2D = $GameCustomization
@onready var main_menu_button: Button = $MainMenuButton

const BLOCK = preload("res://Scenes/GamePieces/Block.tscn")
const screen_size: Vector2 = Vector2(1152, 648)
@onready var label: Label = $Label
@onready var players: Label = $Players


func _ready() -> void:
	SignalBus.end_game.connect(_end_game)
	SignalBus.start_game.connect(_start_game)
	SignalBus.start_placement_phase.connect(_start_placement_phase)
	SignalBus.start_rotation_phase.connect(_start_rotation_phase)

func _start_game() -> void:
	main_menu.hide()
	main_menu_button.show()
	game_customization.hide()
	
	GameManager.CurrentPlayer = GameManager.PlayerOrder[0]
	GameManager.PlayerOrderIndex = 0
	label.text = GameManager.CurrentPlayer + ":
		Place your marble"
	players.text = GameManager.VSMessage
	create_blocks()

#creates a grid of blocks, each which contain 9 spaces
func create_blocks() -> void:
	for i in range(GameManager.BlockRows):
		for j in range(GameManager.BlockColumns):
			var instance = BLOCK.instantiate()
			instance.position = Vector2(j * (576.0/GameManager.BlockColumns) + (screen_size.x/2) - 288, i * (576.0/GameManager.BlockRows) + (screen_size.y/2) - 288)
			instance.block_coordinate = (i+1) * 10 + (j+1)
			instance.scale = Vector2(2.0/GameManager.BlockRows, 2.0/GameManager.BlockColumns)
			add_child(instance)

#changes label text at start of placement phase
func _start_placement_phase() -> void:
	label.text = GameManager.CurrentPlayer + ":
		Place your marble"
	
#changes label text at start of rotation phase
func _start_rotation_phase() -> void:
	label.text = GameManager.CurrentPlayer + ":
		Rotate a block"

#shows the winner message once the game ends
func _end_game(message) -> void:
	label.text = message
	
#goes to the main menu
func _on_main_menu_button_pressed() -> void:
	main_menu_button.hide()
	main_menu.show()
	label.text = ""
	players.text = ""
	SignalBus.clear_board.emit()
