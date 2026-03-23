extends Node2D

@onready var main_menu: Node2D = $"../MainMenu"

var current_page: String = "Mode Selection"
@onready var mode_selection: Node2D = $ModeSelection
@onready var team_selection: Node2D = $TeamSelection
@onready var color_allocation: Node2D = $ColorAllocation


func _ready() -> void:
	pass # Replace with function body.

func _on_back_pressed() -> void:
	match current_page:
		"Mode Selection":
			self.hide()
			main_menu.show()
		"Team Selection":
			go_to_page("Mode Selection")
		"Color Allocation":
			go_to_page("Team Selection")


func _on_pentago_pressed() -> void:
	set_board_settings(2)
	GameManager.PlayerOrder = ["White", "Black"]
	set_player_settings()
	SignalBus.start_game.emit()

func _on_pentago_xl_pressed() -> void:
	set_board_settings(3)
	go_to_page("Team Selection")
	
func go_to_page(page_name) -> void:
	match page_name:
		"Mode Selection":
			mode_selection.show()
			team_selection.hide()
			color_allocation.hide()
			current_page = "Mode Selection"
		"Team Selection":
			mode_selection.hide()
			team_selection.show()
			color_allocation.hide()
			current_page = "Team Selection"
		"Color Allocation":
			mode_selection.hide()
			team_selection.hide()
			color_allocation.show()
			current_page = "Color Allocation"


func set_board_settings(size) -> void:
	GameManager.BlockRows = size
	GameManager.BlockColumns = size
	GameManager.SpaceRows = GameManager.BlockRows * 3
	GameManager.SpaceColumns = GameManager.BlockColumns * 3
	
func set_player_settings() -> void:
	GameManager.CurrentPlayer = GameManager.PlayerOrder[0]
	GameManager.CurrentPhase = "Placement"



func _on_four_players_ffa_pressed() -> void:
	GameManager.PlayerAmount = 4
	GameManager.PlayerOrder = ["Blue", "Red", "Green", "Yellow"]
	SignalBus.start_game.emit()
	#go_to_page("Color Allocation")

func _on_two_players_two_colors_pressed() -> void:
	GameManager.PlayerAmount = 2
	GameManager.PlayerOrder = ["Blue", "Red", "Green", "Yellow"]
	SignalBus.start_game.emit()
	#go_to_page("Color Allocation")

func _on_two_players_one_color_pressed() -> void:
	GameManager.PlayerAmount = 2
	GameManager.PlayerOrder = ["Blue", "Red"]
	SignalBus.start_game.emit()
	#go_to_page("Color Allocation")
