extends Node

var check_coordinate: int
var current_row: int

var first_space_coordinate: int
var second_space_coordinate: int
var first_space_color: String
var second_space_color: String

var winners = []

func _ready() -> void:
	SignalBus.send_first_space_color.connect(_send_first_space_color)
	SignalBus.send_second_space_color.connect(_send_second_space_color)

#checks if the ball that was placed creates a five-in-a-row
func CheckWinPlacement(space_coordinate, color) -> void:
	first_space_coordinate = space_coordinate
	first_space_color = color
	if check_horizontal_win():
		set_winner(first_space_color)
	elif check_vertical_win():
		set_winner(first_space_color)
	elif check_diagonal_win():
		set_winner(first_space_color)
	else:
		#if a five-in-a-row was not created, then it moves to the rotation phase
		SignalBus.start_rotation_phase.emit()
		
func CheckWinRotation(spaces) -> void:
	for space in spaces:
		SignalBus.get_first_space_color.emit(space)
		if first_space_color != "Empty":
			first_space_coordinate = space
			if winners != []:
				pass
			else:
				for color in winners:
					if first_space_color == color:
						break
				
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
#if a five-in-a-row is created for both players, then it is a tie
func set_winner(winner) -> void:
	if winner == "Tie":
		SignalBus.end_game.emit("It's a Tie!")
	else:
		SignalBus.end_game.emit(winner + " wins!")

#if a player got a five-in-a-row, the game ends
#otherwise, the game continues with the next player taking their turn
func check_win_condition() -> void:
	if white_won && black_won:
		set_winner("Tie")
	elif white_won:
		set_winner("White")
	elif black_won:
		set_winner("Black")
	else:
		if GameManager.CurrentPlayer == GameManager.PlayerOrder[-1]:
			GameManager.CurrentPlayer = GameManager.PlayerOrder[0]
			GameManager.PlayerOrderIndex = 0
		else: 
			GameManager.PlayerOrderIndex += 1
			GameManager.CurrentPlayer = GameManager.PlayerOrder[GameManager.PlayerOrderIndex]
		SignalBus.start_placement_phase.emit()
