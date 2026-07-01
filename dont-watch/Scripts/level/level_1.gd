extends Node3D

@onready var hunt_timer: Timer = $HuntTimer
@onready var vanish_timer: Timer = $VanishTimer
@onready var monster: Node3D = $Monster/Monster

@onready var pos_point_back: Marker3D = $Monster/PosPointBack
@onready var pos_point_center: Marker3D = $Monster/PosPointCenter
@onready var pos_point_left: Marker3D = $Monster/PosPointLeft
@onready var pos_point_right: Marker3D = $Monster/PosPointRight
@onready var pos_point_front: Marker3D = $Monster/PosPointFront

var min_hunt_interval = 3.0
var max_hunt_interval = 6.0

var pos_points: Array [Marker3D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pos_points = [pos_point_back, pos_point_center, pos_point_left, pos_point_right]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameManager.Lantern_light_off == true:
		if hunt_timer.is_stopped():
			hunt_timer.start(randf_range(min_hunt_interval, max_hunt_interval))
		vanish_timer.stop()
	else:
		hunt_timer.stop()
		if vanish_timer.is_stopped():
			vanish_timer.start()
			
		
func _on_hunt_timer_timeout() -> void:
	var pos_select = pos_points.pick_random().global_position
	monster.visible = true
	monster.global_position = pos_select

func _on_vanish_timer_timeout() -> void:
	monster.visible = false
