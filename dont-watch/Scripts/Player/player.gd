extends Node3D

var max_fuel := 100.0
var current_fuel := 100.0
var fuel_loss_rate := 4.0

@export var lantern_energy_max := 1.0
@export var lantern_energy_min := 0.0
@export var fade_speed := 10.0

@export var lantern: SpotLight3D

@onready var fuel_bar: ProgressBar = $"../CanvasLayer/FuelBar"

#Player Hand Mechanics
@onready var BookHand = $"Camera3D/Book Hand"
@onready var CastingHand = $"Camera3D/Casting Hand"
@onready var BookOnly = $Camera3D/JustBook
@onready var HolySound = $"Camera3D/Holy Effect"

#Signal Processing
signal HolyLight()

func _ready() -> void:
	lantern.light_energy = 0
	BookHand.visible = false
	CastingHand.visible = false
	BookOnly.visible = true
 
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("light"):
		HolySound.play()
	if Input.is_action_pressed("light") and current_fuel > 0 :
		BookHand.visible = true
		CastingHand.visible = true
		BookOnly.visible = false
		lantern.light_energy = move_toward(lantern.light_energy, lantern_energy_max, fade_speed * delta)
		current_fuel -= fuel_loss_rate * delta
		fuel_bar.value = current_fuel
		emit_signal("HolyLight")
	else:
		HolySound.stop()
		BookHand.visible = false
		CastingHand.visible = false
		BookOnly.visible = true
		lantern.light_energy = move_toward(lantern.light_energy, lantern_energy_min, fade_speed * delta)
	
	if lantern.light_energy <= 0:
		GameManager.Lantern_light_off = true
	else:
		GameManager.Lantern_light_off = false
	if current_fuel <= 0:
		current_fuel = 0
	
func _on_area_3d_area_entered(_area: Area3D) -> void:
	get_tree().change_scene_to_file.call_deferred("res://Scenes/Monster/JumpScare.tscn")
