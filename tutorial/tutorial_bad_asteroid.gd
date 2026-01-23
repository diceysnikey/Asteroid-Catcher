extends Node2D

var speed:int
const outOfViewPadding = 32 * 3
var triggeredMouth = false
var toggleProcess = false

func _check_color_blindness() -> void:
	if BlindnessToggle.colorBlindness:
		$Sprite2D.texture = preload("res://textures_and_audios/badasteroid_blindness.png")
	else:
		$Sprite2D.texture = preload("res://textures_and_audios/badAsteroid.png")

func _dodge_failed(_area: Area2D) -> void:
	speed = 0
	position.x = -200
	Signalbus.tutorial_dodge_failed.emit()

func _ready() -> void:
	_check_color_blindness()
	$Area2D.area_entered.connect(_dodge_failed)
	position.x = -200
	position.y = get_viewport_rect().size.y / 2
	toggleProcess = true

func _process(delta: float) -> void:
	if toggleProcess:
		speed += 1
		position.x += speed * delta
		if position.x > (get_viewport_rect().size.x + outOfViewPadding):
			Signalbus.tutorial_asteroid_dodged.emit()
