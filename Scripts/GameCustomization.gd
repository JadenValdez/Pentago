extends Node2D

@onready var main_menu: Node2D = $"../MainMenu"

var current_page: String = "Mode Selection"
@onready var mode_selection: Node2D = $ModeSelection
@onready var team_selection: Node2D = $TeamSelection


func _ready() -> void:
	pass # Replace with function body.

#goes to previous page when clicked
func _on_back_pressed() -> void:
	match current_page:
		"Mode Selection":
			self.hide()
			main_menu.show()
		"Team Selection":
			go_to_page("Mode Selection")

#starts a standard game of Pentago
func _on_pentago_pressed() -> void:
	set_board_settings(2)
	GameManager.PlayerAmount = 2
	GameManager.PlayerOrder = ["White", "Black"]
	GameManager.VSMessage = ""
	set_player_settings()
	SignalBus.start_game.emit()

#goes to the team selection page for Pentago XL
func _on_pentago_xl_pressed() -> void:
	set_board_settings(3)
	go_to_page("Team Selection")
	
#goes to a certain page
func go_to_page(page_name) -> void:
	match page_name:
		"Mode Selection":
			mode_selection.show()
			team_selection.hide()
			current_page = "Mode Selection"
		"Team Selection":
			mode_selection.hide()
			team_selection.show()
			current_page = "Team Selection"

#creates board settings depending on the mode chosen
func set_board_settings(size) -> void:
	GameManager.BlockRows = size
	GameManager.BlockColumns = size
	GameManager.SpaceRows = GameManager.BlockRows * 3
	GameManager.SpaceColumns = GameManager.BlockColumns * 3
	
#sets current player and phase
func set_player_settings() -> void:
	GameManager.CurrentPlayer = GameManager.PlayerOrder[0]
	GameManager.CurrentPhase = "Placement"


#starts a 4p FFA game
func _on_four_players_ffa_pressed() -> void:
	GameManager.PlayerAmount = 4
	GameManager.PlayerOrder = ["Blue", "Red", "Green", "Yellow"]
	GameManager.VSMessage = "Blue vs Red vs 
	Green vs Yellow"
	set_player_settings()
	SignalBus.start_game.emit()

#starts a 2 team game using two colors each
func _on_two_players_two_colors_pressed() -> void:
	GameManager.PlayerAmount = 2
	GameManager.PlayerOrder = ["Blue", "Red", "Green", "Yellow"]
	GameManager.VSMessage = "Blue + Green
	vs
	Red + Yellow"
	set_player_settings()
	SignalBus.start_game.emit()

#starts a 2 team game using one color each
func _on_two_players_one_color_pressed() -> void:
	GameManager.PlayerAmount = 2
	GameManager.PlayerOrder = ["Blue", "Red"]
	GameManager.VSMessage = "Blue vs Red"
	set_player_settings()
	SignalBus.start_game.emit()
