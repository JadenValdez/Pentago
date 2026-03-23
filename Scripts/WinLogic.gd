extends Node

var check_coordinate: int
var current_row: int

var first_space_coordinate: int
var second_space_coordinate: int
var first_space_color: String
var second_space_color: String

var winners: Array = []
var color_already_won: bool = false

func _ready() -> void:
	SignalBus.send_first_space_color.connect(_send_first_space_color)
	SignalBus.send_second_space_color.connect(_send_second_space_color)
	SignalBus.start_game.connect(_start_game)

#reset the winner array when starting a new game
func _start_game() -> void:
	winners = []

#checks if the ball that was placed creates a five-in-a-row
func CheckWinPlacement(space_coordinate, color) -> void:
	first_space_coordinate = space_coordinate
	first_space_color = color
	if check_horizontal_win():
		winners = [first_space_color]
		set_winner()
	elif check_vertical_win():
		winners = [first_space_color]
		set_winner()
	elif check_diagonal_win():
		winners = [first_space_color]
		set_winner()
	else:
		#if a five-in-a-row was not created, then it moves to the rotation phase
		SignalBus.start_rotation_phase.emit()
		
func CheckWinRotation(spaces) -> void:
	for space in spaces:
		SignalBus.get_first_space_color.emit(space)
		if first_space_color != "Empty":
			first_space_coordinate = space
			if winners != []:
				color_already_won = false
				for color in winners:
					if first_space_color == color:
						color_already_won = true
				if !color_already_won:
					if check_horizontal_win():
						add_winner(first_space_color)
					elif check_vertical_win():
						add_winner(first_space_color)
					elif check_diagonal_win():
						add_winner(first_space_color)
			else:
				if check_horizontal_win():
					add_winner(first_space_color)
				elif check_vertical_win():
					add_winner(first_space_color)
				elif check_diagonal_win():
					add_winner(first_space_color)
				
				
	check_win_condition()
	
#checks for a horizontal five-in-a-row
func check_horizontal_win() -> bool:
	current_row = floor(first_space_coordinate/10.0)
	for i in range(5):
		for j in range(5):
			second_space_coordinate = first_space_coordinate - 4 + i + j
			
			#if the coordinate is not on the same row (like 27 and 31), then a five-in-a-row is not possible
			if floor(second_space_coordinate/10.0) != current_row:
				break
				
			#if the coordinate doesn't exist on the board (like 20 or 28 on a board with 6 columns), then a five-in-a-row is not possible
			if second_space_coordinate % 10 == 0 || second_space_coordinate % 10 > GameManager.SpaceColumns:
				break
				
			#if the color of the coordinate is not the same, then a five-in-a-row is not possible
			if !same_color():
				break
			
			#if all five spaces have been checked with no errors, then a five-in-a-row has been formed
			if j == 4:
				return true
	
	#if all five-in-a-row possibilites that use this space have an error, then a horizontal five-in-a-row is not possible
	return false

#checks for a vertical five-in-a-row
func check_vertical_win() -> bool:
	for i in range(5):
		for j in range(5):
			second_space_coordinate = first_space_coordinate - 40 + i*10 + j*10
			
			#if the coordinate does not exist on the board (like 4 or 72 on a board with 6 rows, then a five-in-a-row is not possible
			if second_space_coordinate < 10 || second_space_coordinate > (GameManager.SpaceRows+1) * 10:
				break
				
			if !same_color():
				break
			
			if j == 4:
				return true
	return false

#checks for a diagonal five-in-a-row
#this combines the logic for the hoizontal and vertical checks
func check_diagonal_win() -> bool:
	current_row = floor(first_space_coordinate/10.0)
	for i in range(5):
		for j in range(5):
			second_space_coordinate = first_space_coordinate - 4 + i + j
			
			if floor(second_space_coordinate/10.0) != current_row:
				break
					
			if second_space_coordinate % 10 == 0 || second_space_coordinate % 10 > GameManager.SpaceColumns:
				break
				
			second_space_coordinate = second_space_coordinate - 40 + i*10 + j*10
			
			if second_space_coordinate < 10 || second_space_coordinate > (GameManager.SpaceRows+1) * 10:
				break
				
			if !same_color():
				break
			
			if j == 4:
				return true
	return false
	
#checks if both balls are the same color
#if they aren't, then a five-in-a-row isn't possible
func same_color() -> bool:
	SignalBus.get_second_space_color.emit(second_space_coordinate)
	if first_space_color == second_space_color:
		return true
	else:
		return false

#gets the color of the second space to check for
func _send_first_space_color(status) -> void:
	first_space_color = status

#gets the color of the second space to check against
func _send_second_space_color(status) -> void:
	second_space_color = status
	
#if a five-in-a-row is created, then whoever owns it is the winner
#if a five-in-a-row is created for different teams, then it is a tie
func set_winner() -> void:
	GameManager.CurrentPhase = "Game Over"
	if winners.size() == 1:
		SignalBus.end_game.emit(winners[0] + " wins!")
	elif GameManager.PlayerAmount == 2 && GameManager.PlayerOrder.size() == 4:
		if winners.has("Blue") && winners.has("Green") && !winners.has("Red") && !winners.has("Yellow"):
			SignalBus.end_game.emit("Blue and Green win!")
		elif winners.has("Red") && winners.has("Yellow") && !winners.has("Blue") && !winners.has("Green"):
			SignalBus.end_game.emit("Red and Yellow win!")
		else:
			SignalBus.end_game.emit("It's a Tie!")
	else:
		SignalBus.end_game.emit("It's a Tie!")
		
#if a player made a five-in-a-row during the rotation phase, then add them to the winner list
func add_winner(winner) -> void:
	if !winners.has(winner):
		winners.append(winner)

#if a player got a five-in-a-row, the game ends
#otherwise, the game continues with the next player taking their turn
func check_win_condition() -> void:
	if winners.is_empty():
		if GameManager.CurrentPlayer == GameManager.PlayerOrder[-1]:
			GameManager.CurrentPlayer = GameManager.PlayerOrder[0]
			GameManager.PlayerOrderIndex = 0
		else: 
			GameManager.PlayerOrderIndex += 1
			GameManager.CurrentPlayer = GameManager.PlayerOrder[GameManager.PlayerOrderIndex]
		SignalBus.start_placement_phase.emit()
	else:
		set_winner()
		
		
