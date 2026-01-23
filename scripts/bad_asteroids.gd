extends Node2D

var speed:int
const outOfViewPadding = 32
var triggeredMouth = false
var toggleProcess = false

func _check_color_blindness() -> void:
	if BlindnessToggle.colorBlindness:
		$Sprite2D.texture = preload("res://textures_and_audios/badasteroid_blindness.png")
	else:
		$Sprite2D.texture = preload("res://textures_and_audios/badAsteroid.png")

func _ready() -> void:
	_check_color_blindness()

func _process(delta: float) -> void:
	if toggleProcess:
		speed += 1
		position.x += (speed * ElapsedTimer.elapsedTime) * delta
		if position.x > (get_viewport_rect().size.x + outOfViewPadding):
			Signalbus.return_asteroid_to_pool.emit(self)
