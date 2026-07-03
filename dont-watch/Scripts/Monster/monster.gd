extends Node3D
@onready var ScreamTimer = $Scream/Timer
@onready var NormalMob = %SpriteCenter
@onready var DamagedMob = $DamagedSprite
@onready var area_3d: Area3D = $Area3D
@onready var collision_shape_3d: CollisionShape3D = $Area3D/CollisionShape3D

func _process(_delta: float) -> void:
	DamagedMob.visible = false
	NormalMob.visible = true
	if GameManager.Lantern_light_off == false:
		area_3d.set_deferred("monitoring", true)
	elif GameManager.Lantern_light_off == true:
		area_3d.set_deferred("monitoring", false)
		
func _on_timer_timeout() -> void:
	$Scream.stop()

func _on_level_1_monster_damage() -> void:
	NormalMob.visible = false
	DamagedMob.visible = true
	$AnimationPlayer.play("Hover_Damaged")
	$Scream.play()
	ScreamTimer.start()
