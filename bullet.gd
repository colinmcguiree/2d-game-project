extends Area2D

var speed: float = 400.0
var direction: Vector2 = Vector2.RIGHT

func _ready():
	# Automatically destroy the bullet after 5 seconds
	# so it doesn't fly forever and waste memory
	var lifetime_timer = Timer.new()
	lifetime_timer.wait_time = 5.0
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect(_on_lifetime_expired)
	add_child(lifetime_timer)
	lifetime_timer.start()

func _physics_process(delta):
	# Move the bullet in its direction every frame
	# delta ensures smooth movement regardless of framerate
	position += direction * speed * delta

func _on_lifetime_expired():
	queue_free()  # Remove the bullet from the game
