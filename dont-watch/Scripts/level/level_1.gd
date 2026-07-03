extends Node3D

@onready var hunt_timer: Timer = $HuntTimer
@onready var vanish_timer: Timer = $VanishTimer
@onready var monster: Node3D = $Monster/Monster
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var anim_player_complete: AnimationPlayer = $"Wall Raise"

var min_hunt_interval = 3.0
var max_hunt_interval = 10.0
var hunt_triggered = false
var GameComplete = false

#Signal Processing
signal MonsterDamage()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.monster_retreating = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GameManager.Lantern_light_off == true and GameComplete == false:
		if not hunt_triggered:
			hunt_timer.start(randf_range(min_hunt_interval, max_hunt_interval))
			hunt_triggered = true
		vanish_timer.stop()
	elif GameManager.Lantern_light_off == false and GameComplete == false:
		hunt_timer.stop()
		hunt_triggered = false
		if vanish_timer.is_stopped():
			vanish_timer.start()
	elif GameComplete == true:
		hunt_timer.stop()
		vanish_timer.stop()
		anim_player_complete.play("Wall Lift")
	
func _on_hunt_timer_timeout() -> void:
	GameManager.monster_retreating = false
	play_random_animation()
	print(anim_player.current_animation)

func _on_vanish_timer_timeout() -> void:
	GameManager.monster_retreating = true
	reverse_current_animation()
	
func _on_player_holy_light() -> void:
	if GameManager.monster_retreating == false:
		emit_signal("MonsterDamage")

func play_random_animation() -> void:
	var anim_list: PackedStringArray = anim_player.get_animation_list()
	if anim_list.is_empty():
		return
	var random_anim: String = anim_list[randi() % anim_list.size()]
	anim_player.play(random_anim)

func reverse_current_animation() -> void:
	if anim_player.current_animation == null:
		return
	anim_player.play_backwards(anim_player.current_animation)

func _on_torch_game_complete() -> void:
	GameComplete = true


func _on_wall_raise_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file.call_deferred("res://Scenes/Levels/Win.tscn")
