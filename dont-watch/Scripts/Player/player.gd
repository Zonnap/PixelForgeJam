extends Node3D

@export var lantern_energy_max := 1.0
@export var lantern_energy_min := 0.0
@export var fade_speed := 10.0

@export var lantern: SpotLight3D

func _ready() -> void:
	lantern.light_energy = 0
 
func _process(delta: float) -> void:
	if Input.is_action_pressed("light"):
		lantern.light_energy = move_toward(lantern.light_energy, lantern_energy_max, fade_speed * delta)
	else:
		lantern.light_energy = move_toward(lantern.light_energy, lantern_energy_min, fade_speed * delta)
	print(lantern.light_energy)
