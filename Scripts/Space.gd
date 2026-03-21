extends Node2D

@onready var control: Control = $Control
@onready var label: Label = $Label

const COLORS: Dictionary = {
	"White": Color(1, 1, 1),
	"Black": Color(0, 0, 0),
	"Empty": Color(0.5, 0.5, 0.5)
}

var space_coordinate: int
var status: String

func _ready() -> void:
	SignalBus.start_placement_phase.connect(_start_placement_phase)
	SignalBus.start_rotation_phase.connect(_start_rotation_phase)
	SignalBus.get_second_space_color.connect(_get_second_space_color)
	SignalBus.set_space_color.connect(_set_space_color)
	SignalBus.get_first_space_color.connect(_get_first_space_color)
	label.text = str(space_coordinate)

#changes color based on who's ball it currently holds
func _draw() -> void:
	draw_circle(Vector2(0, 0), 32, COLORS[status])

#places the current player's ball on this space when clicked
func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				status = GameManager.CurrentPlayer
				queue_redraw()
				WinLogic.CheckWinPlacement(space_coordinate, GameManager.CurrentPlayer)

#becomes active during the placement phase
func _start_placement_phase() -> void:
	control.show()
	label.show()
	
#becomes inactive during the placement phase
func _start_rotation_phase() -> void:
	control.hide()
	label.hide()
	
#sends information about its own color for win condition purposes
func _get_second_space_color(second_coordinate) -> void:
	if second_coordinate == space_coordinate:
		SignalBus.send_second_space_color.emit(status)
		
#sends information about its own color for rotation purposes
func _get_first_space_color(first_coordinate) -> void:
	if first_coordinate == space_coordinate:
		SignalBus.send_first_space_color.emit(status)

func _set_space_color(coordinate, space_color) -> void:
	if coordinate == space_coordinate:
		status = space_color
		queue_redraw()
