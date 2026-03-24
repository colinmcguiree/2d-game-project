extends CharacterBody2D

@export var bullet_scene_2: PackedScene
@onready var bspawnA = $BossBSpawn_A
@onready var shoot_timer = $Timer
@onready var move_timer = $MoveTimer
@onready var healthbar = $GorgyHP

var health = 999
var bullet_angle_offset = 0.0
var num_bullets = 8

# --- Movement variables ---
var orbit_angle = 0.0
var orbit_speed = 0.4
var orbit_radius = 60.0
var wobble_angle = 0.0
var wobble_speed = 0.7
var wobble_amount = 30.0

# --- Map boundaries ---
var map_min = Vector2(-150, -200)
var map_max = Vector2(170, 100)


func fire():
	var angle_step = (2 * PI) / num_bullets

	for i in range(num_bullets):
		var angle = angle_step * i + bullet_angle_offset
		var new_bullet = bullet_scene_2.instantiate()
		new_bullet.direction = Vector2.from_angle(angle)
		new_bullet.shooter = self
		get_parent().add_child(new_bullet)
		new_bullet.position = bspawnA.global_position

	bullet_angle_offset += 0.3


func _ready() -> void:
	shoot_timer.wait_time = 2
	shoot_timer.start()


func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
		return

	healthbar.text = str(health)

	orbit_angle += orbit_speed * delta
	wobble_angle += wobble_speed * delta

	var center = Vector2(11, -81)
	var base_pos = center + Vector2(cos(orbit_angle), sin(orbit_angle)) * orbit_radius
	var wobble = Vector2(cos(wobble_angle * 1.3), sin(wobble_angle * 0.9)) * wobble_amount
	position = (base_pos + wobble).clamp(map_min, map_max)


func _on_timer_timeout() -> void:
	fire()


func _on_move_timer_timeout() -> void:
	orbit_radius = randf_range(40.0, 80.0)
	wobble_amount = randf_range(10.0, 40.0)
