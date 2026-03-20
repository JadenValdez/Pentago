extends Node2D

const SPACE = preload("res://Scenes/Space.tscn")
@onready var control: Control = $Control

var block_coordinate: int

func _ready() -> void:
	SignalBus.start_placement_phase.connect(_start_placement_phase)
	SignalBus.start_rotation_phase.connect(_start_rotation_phase)
	create_spaces()

func create_spaces() -> void:
	for x in range(3):
		for y in range(3):
			var instance = SPACE.instantiate()
			instance.space_coordinate = (block_coordinate-11) * 3 + (y+1) * 10 + (x+1)
			instance.status = "Empty"
			instance.position = Vector2(x * 96 + 48, y * 96 + 48)
			add_child(instance)

func _start_placement_phase() -> void:
	control.hide()
	
func _start_rotation_phase() -> void:
	control.show()

func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				pass
