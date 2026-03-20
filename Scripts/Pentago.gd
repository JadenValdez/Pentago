extends Node2D

const BLOCK = preload("res://Scenes/Block.tscn")
const screen_size = Vector2(1152, 648)


func _ready() -> void:
	SignalBus.start_rotation_phase.connect(_start_rotation_phase)
	create_blocks()

#creates a grid of blocks, each which contain 9 spaces
func create_blocks() -> void:
	for i in range(GameManager.BlockRows):
		for j in range(GameManager.BlockColumns):
			var instance = BLOCK.instantiate()
			instance.position = Vector2(j * 288 + (screen_size.x/2) - (GameManager.BlockColumns * 288)/2.0, i * 288 + (screen_size.y/2) - (GameManager.BlockRows * 288)/2.0)
			instance.block_coordinate = (i+1) * 10 + (j+1)
			add_child(instance)

#changes the current player
#currently a stand-in, as rotation phase isnt implemented yet
func _start_rotation_phase() -> void:
	if GameManager.CurrentPlayer == "White":
		GameManager.CurrentPlayer = "Black"
	else: 
		GameManager.CurrentPlayer = "White"
	await get_tree().create_timer(0.1).timeout
	SignalBus.start_placement_phase.emit()
