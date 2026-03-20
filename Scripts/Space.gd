extends Node2D

@onready var control: Control = $Control

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

func _draw() -> void:
	draw_circle(Vector2(0, 0), 32, COLORS[status])

func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				status = "Black"
				queue_redraw()

func _start_placement_phase() -> void:
	control.show()
	
func _start_rotation_phase() -> void:
	control.hide()
