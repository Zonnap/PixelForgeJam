extends Node

@onready var timer: Timer = $Timer
@onready var Audio = $Heartbeat
# Define the minimum and maximum wait times in seconds
@export var wait_time: float = 25.0

@onready var Torch1 = $"000Torch"
@onready var Torch2 = $"000Torch2"
@onready var Torch3 = $"000Torch3"
@onready var Torch4 = $"000Torch4"
@onready var Torch5 = $"000Torch5"
@onready var Torch6 = $"000Torch6"

var TorchHolder: Array = []
var TorchCounter: int = 0

#Signal Processing
signal GameComplete()
signal TorchDepletion(TorchGone)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	TorchHolder = [Torch1, Torch2, Torch3, Torch4, Torch5, Torch6]
	Audio.volume_db = 0
	Audio.play()
	# Start the random cycle when the scene begins
	start_random_timer()

func _on_timer_timeout() -> void:
		# 2. Pick a new random time and start the timer again
	if TorchCounter <= TorchHolder.size()-1:
		var OffTorch = TorchHolder[TorchCounter]
		OffTorch.visible = false
		TorchCounter += 1
		Audio.volume_db += 3
		start_random_timer()
		TorchDepletion.emit(TorchCounter)
	if TorchCounter >= TorchHolder.size():
		emit_signal("GameComplete")
	
func start_random_timer() -> void:
	# Assign the new time and start the timer
	timer.wait_time = wait_time
	timer.start()
