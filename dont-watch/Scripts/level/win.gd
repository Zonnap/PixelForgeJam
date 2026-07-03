extends Node3D
@onready var ControlButton = $Control/Replay
@onready var CompleteAnimation = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ControlButton.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if CompleteAnimation.is_playing() == false:
		ControlButton.visible = true

func _on_replay_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://Scenes/Levels/level_1.tscn")
