extends Camera3D

@export var RandomStrength: float = 0.0625
@export var ShakeFade: float = 5

var rng = RandomNumberGenerator.new()
var MonsterDamaged = false

var shake_strength: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if MonsterDamaged == true:
		apply_shake()
		
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0,ShakeFade * delta)
		
		h_offset = randomOffset().x
		v_offset = randomOffset().y
	MonsterDamaged = false

func apply_shake():
	shake_strength = RandomStrength

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))

func _on_level_1_monster_damage() -> void:
	MonsterDamaged = true
