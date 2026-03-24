extends Node2D

var selected_block: int

func _ready() -> void:
	SignalBus.start_placement_phase.connect(_start_placement_phase)
	SignalBus.select_block.connect(_select_block)
	SignalBus.end_game.connect(_end_game)

#becomes inactive at the start of the placement phase
func _start_placement_phase() -> void:
	self.hide()
	
#becomes active when a block is chosen
func _select_block(block_coordinate) -> void:
	selected_block = block_coordinate
	self.show()

#rotates the selected block counterclockwise
func _on_cc_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				RotationLogic.RotateCounterClockwise(selected_block)

#rotates the selected block clockwise
func _on_c_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				RotationLogic.RotateClockwise(selected_block)
				
#becomes inactive when the game ends
func _end_game(_message) -> void:
	pass
