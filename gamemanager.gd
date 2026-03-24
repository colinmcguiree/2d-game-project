extends Node2D

var game_over = false

@onready var player1 = $Player
@onready var player2 = $SecondPlayer
@onready var boss = $boss
@onready var overlay = $Overlay
@onready var overlay_label = $Overlay/Label


func _process(_delta):
	if game_over:
		return

	var p1_alive = is_instance_valid(player1)
	var p2_alive = is_instance_valid(player2)
	var boss_alive = is_instance_valid(boss)

	# --- GAME OVER conditions ---

	# Gorgochov kills both players
	if not p1_alive and not p2_alive:
		show_screen("GAME OVER\nGorgochov remains victorious")
		return

	# Player 1 kills Gorgochov AND Player 2
	if p1_alive and not p2_alive and not boss_alive:
		show_screen("GAME OVER\nPlayer 1 betrayed their ally!\nPlayer 1 wins!")
		return

	# Player 2 kills Gorgochov AND Player 1
	if p2_alive and not p1_alive and not boss_alive:
		show_screen("GAME OVER\nPlayer 2 betrayed their ally!\nPlayer 2 wins!")
		return


func show_screen(message: String):
	game_over = true
	overlay.visible = true
	overlay_label.text = message
