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

	# Both players dead
	if not p1_alive and not p2_alive:
		show_screen("GAME OVER\nBoth players defeated...")
		return

	# Boss dead — check who survived
	if not boss_alive:
		if p1_alive and p2_alive:
			show_screen("YOU WIN!\nBoth players defeated the boss!")
		else:
			var survivor = "Player 1" if p1_alive else "Player 2"
			show_screen("YOU WIN!\n" + survivor + " defeated the boss!")
		return


func show_screen(message: String):
	game_over = true
	overlay.visible = true
	overlay_label.text = message
