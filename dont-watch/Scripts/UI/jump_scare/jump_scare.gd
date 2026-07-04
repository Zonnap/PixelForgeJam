extends Node3D
@onready var Anim_play = $AnimationPlayer
func _on_button_pressed() -> void:
	Anim_play.stop()
	get_tree().change_scene_to_file.call_deferred("res://Scenes/Levels/level_1.tscn")
