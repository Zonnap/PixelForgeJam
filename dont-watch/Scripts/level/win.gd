extends Node3D
@onready var ControlButton = $Control/Replay

func _on_replay_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://Scenes/Levels/level_1.tscn")
