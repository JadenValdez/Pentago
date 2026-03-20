extends Node

var check_coordinate: int
var current_row: int
#var current_column: int

var first_space_coordinate: int
var second_space_coordinate: int
var first_space_color: String
var second_space_color: String

func _ready() -> void:
	SignalBus.send_second_space_color.connect(_send_second_space_color)

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
		SignalBus.start_rotation_phase.emit()
	
func check_horizontal_win() -> bool:
	current_row = floor(first_space_coordinate/10.0)
	for i in range(5):
		for j in range(5):
			second_space_coordinate = first_space_coordinate - 4 + i + j
			
			if floor(second_space_coordinate/10.0) != current_row:
				break
				
			if second_space_coordinate % 10 == 0 || second_space_coordinate % 10 > GameManager.SpaceColumns:
				break
				
			if !same_color():
				break
			
			if j == 4:
				return true
	return false

func check_vertical_win() -> bool:
	for i in range(5):
		for j in range(5):
			second_space_coordinate = first_space_coordinate - 40 + i*10 + j*10
			
			if second_space_coordinate < 10 || second_space_coordinate > (GameManager.SpaceRows+1) * 10:
				break
				
			if !same_color():
				break
			
			if j == 4:
				return true
	return false

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
	
func same_color() -> bool:
	SignalBus.get_second_space_color.emit(second_space_coordinate)
	if first_space_color == second_space_color:
		return true
	else:
		return false

func _send_second_space_color(status) -> void:
	second_space_color = status
	
func set_winner(winner) -> void:
	print(winner)
