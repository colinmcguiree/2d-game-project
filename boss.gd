extends Node2D

@export var bullet_scene_2: PackedScene
@onready var bspawnA = $BossBSpawn_A
@onready var shoot_timer = $Timer
@onready var move_timer = $MoveTimer  # We'll add this node below

var health = 500
var speed = 80.0                  # How fast the boss moves
var move_direction = Vector2.ZERO # Current movement direction
var bullet_angle_offset = 0.0     # Rotates the shot pattern over time
var num_bullets = 8               # How many bullets fire at once (in a circle)


# Fires 'num_bullets' bullets evenly spread in a circle,
# rotated by the current bullet_angle_offset
func fire():
	var angle_step = (2 * PI) / num_bullets  # Evenly divide a full circle

	for i in range(num_bullets):
		var angle = angle_step * i + bullet_angle_offset
		var new_bullet = bullet_scene_2.instantiate()
		new_bullet.direction = Vector2.from_angle(angle)
		new_bullet.shooter = self
		get_parent().add_child(new_bullet)
		new_bullet.position = bspawnA.global_position

	# Rotate the pattern slightly each time we fire
	bullet_angle_offset += 0.3


# Pick a new random direction to move in
func pick_new_direction():
	var random_angle = randf_range(0, 2 * PI)
	move_direction = Vector2.from_angle(random_angle)


func _ready() -> void:
	pick_new_direction()       # Start moving immediately
	shoot_timer.wait_time = 1.2
	shoot_timer.start()


func _process(delta: float) -> void:
	position += move_direction * speed * delta
	
	var screen = get_viewport_rect().size
	if position.x < 0 or position.x > screen.x:
		move_direction.x *= -1
	if position.y < 0 or position.y > screen.y:
		move_direction.y *= -1


func _on_timer_timeout() -> void:
	fire()


# Called by the MoveTimer — pick a new random direction
func _on_move_timer_timeout() -> void:
	pick_new_direction()
