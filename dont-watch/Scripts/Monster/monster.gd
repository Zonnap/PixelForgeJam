extends Node3D
@onready var ScreamTimer = $Scream/Timer
@onready var NormalMob = %SpriteCenter
@onready var DamagedMob = $DamagedSprite

func _process(delta: float) -> void:
	DamagedMob.visible = false
	NormalMob.visible = true

func _on_timer_timeout() -> void:
	$Scream.stop()

func _on_level_1_monster_damage() -> void:
	NormalMob.visible = false
	DamagedMob.visible = true
	$AnimationPlayer.play("Hover_Damaged")
	$Scream.play()
	ScreamTimer.start()
