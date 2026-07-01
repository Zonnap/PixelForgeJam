extends AudioStreamPlayer3D

@onready var timer: Timer = $Timer

# Define the minimum and maximum wait times in seconds
@export var min_wait_time: float = 15.0
@export var max_wait_time: float = 45.0

func _ready() -> void:
	# Start the random cycle when the scene begins
	start_random_timer()

func _on_timer_timeout() -> void:
	# 1. Play the random sound
	self.play()
	
	# 2. Pick a new random time and start the timer again
	start_random_timer()

func start_random_timer() -> void:
	# Generate a random float between min_wait_time and max_wait_time
	var random_delay = randf_range(min_wait_time, max_wait_time)
	
	# Assign the new time and start the timer
	timer.wait_time = random_delay
	timer.start()
