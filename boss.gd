extends Node2D

@export var bullet_scene_2: PackedScene
@onready var bspawnA = $BossBSpawn_A
var facing = Vector2.DOWN
var health = 500
var angle = 0.1
var angle2 = 0.1
var random = RandomNumberGenerator.new()


func fire():
	var new_bullet = bullet_scene_2.instantiate()
	# bullet = bullet_scene_2
	new_bullet.direction = facing
	new_bullet.shooter = self
	# print(facing)
	get_parent().add_child(new_bullet)
	new_bullet.position = bspawnA.global_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print("pew")
	fire()
	#rotate(0.2)
	#print(rotation)
	facing = Vector2(angle, angle2).normalized()
	print(facing)
	angle -= 1.0
	angle2 += 1.0
