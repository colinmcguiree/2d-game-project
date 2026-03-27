extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _process(delta: float) -> void:
	# Check if the space bar was just pressed
	if Input.is_action_just_pressed("ui_accept"):
		# Replace the path below with the actual path to your scene file
		get_tree().change_scene_to_file("res://UI.tscn")

	pass


	
