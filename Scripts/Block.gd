extends Node2D

const SPACE = preload("res://Scenes/Space.tscn")
@onready var control: Control = $Control

var block_coordinate: int

func _ready() -> void:
	SignalBus.start_placement_phase.connect(_start_placement_phase)
	SignalBus.start_rotation_phase.connect(_start_rotation_phase)
	create_spaces()

#creates 9 empty spaces in a 3x3 grid for each block
func create_spaces() -> void:
	for x in range(3):
		for y in range(3):
			var instance = SPACE.instantiate()
			instance.space_coordinate = (block_coordinate-11) * 3 + (y+1) * 10 + (x+1)
			instance.status = "Empty"
			instance.position = Vector2(x * 96 + 48, y * 96 + 48)
			add_child(instance)

#becomes inactive at the start of the placement phase
func _start_placement_phase() -> void:
	control.hide()

#becomes active at the start of the rotation phase
func _start_rotation_phase() -> void:
	control.show()

#selects the current block as the target for rotation when clicked
func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				SignalBus.select_block.emit(block_coordinate)
