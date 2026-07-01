extends Node3D

var max_fuel := 100.0
var current_fuel := 100.0
var fuel_loss_rate := 4.0

@export var lantern_energy_max := 1.0
@export var lantern_energy_min := 0.0
@export var fade_speed := 10.0

@export var lantern: SpotLight3D

@onready var fuel_bar: ProgressBar = $"../CanvasLayer/FuelBar"


func _ready() -> void:
	lantern.light_energy = 0
 
func _process(delta: float) -> void:
	if Input.is_action_pressed("light"):
		lantern.light_energy = move_toward(lantern.light_energy, lantern_energy_max, fade_speed * delta)
		current_fuel -= fuel_loss_rate * delta
		fuel_bar.value = current_fuel
	else:
		lantern.light_energy = move_toward(lantern.light_energy, lantern_energy_min, fade_speed * delta)
	
	if lantern.light_energy <= 0:
		GameManager.Lantern_light_off = true
	else:
		GameManager.Lantern_light_off = false
	if current_fuel <= 0:
		current_fuel = 0
				
