extends Node

var spaces: Array
var corners: Array
var sides: Array
var middle: int
var selected_space: int
var first_space_color: String
var second_space_color: String

func _ready() -> void:
	SignalBus.send_second_space_color.connect(_send_second_space_color)
	SignalBus.send_first_space_color.connect(_send_first_space_color)

#rotates the selected block counterclockwise
func RotateCounterClockwise(block_coordinate) -> void:
	reset_arrays()
	get_middle(block_coordinate)
	get_corners()
	get_sides()
	corners.reverse()
	sides.reverse()
	rotate_spaces(corners)
	rotate_spaces(sides)
	WinLogic.CheckWinRotation(spaces)

#rotates the selected block clockwise
func RotateClockwise(block_coordinate) -> void:
	reset_arrays()
	get_middle(block_coordinate)
	get_corners()
	get_sides()
	rotate_spaces(corners)
	rotate_spaces(sides)
	WinLogic.CheckWinRotation(spaces)

#reset arrays to get ready for the next rotation
func reset_arrays() -> void:
	spaces.clear()
	corners.clear()
	sides.clear()
	
#gets the middle space of the block and adds it to the spaces array
func get_middle(block_coordinate) -> void:
	middle = (block_coordinate - 11) * 3 + 22
	spaces.append(middle)
	
#gets the coordinates of all corner spaces in clockwise order, starting from top left
func get_corners() -> void:
	selected_space = middle - 11
	add_corner()
	selected_space = middle - 9
	add_corner()
	selected_space = middle + 11
	add_corner()
	selected_space = middle + 9
	add_corner()
	
#gets the coordinates of all side spaces in clockwise order, starting from the top
func get_sides() -> void:
	selected_space = middle - 10
	add_side()
	selected_space = middle + 1
	add_side()
	selected_space = middle + 10
	add_side()
	selected_space = middle - 1
	add_side()
	
#adds the selected space to the spaces and corners arrays
func add_corner() -> void:
	spaces.append(selected_space)
	corners.append(selected_space)
	
#adds the selected space to the spaces and sides arrays
func add_side() -> void:
	spaces.append(selected_space)
	sides.append(selected_space)
	
func rotate_spaces(array) -> void:
	SignalBus.get_first_space_color.emit(array[0])
	SignalBus.get_second_space_color.emit(array[1])
	SignalBus.set_space_color.emit(array[1], first_space_color)
	first_space_color = second_space_color
	SignalBus.get_second_space_color.emit(array[2])
	SignalBus.set_space_color.emit(array[2], first_space_color)
	first_space_color = second_space_color
	SignalBus.get_second_space_color.emit(array[3])
	SignalBus.set_space_color.emit(array[3], first_space_color)
	first_space_color = second_space_color
	SignalBus.get_second_space_color.emit(array[0])
	SignalBus.set_space_color.emit(array[0], first_space_color)
	
#gets the color of the first space to rotate with
func _send_first_space_color(status) -> void:
	first_space_color = status
	
#gets the color of the second space to rotate against
func _send_second_space_color(status) -> void:
	second_space_color = status
