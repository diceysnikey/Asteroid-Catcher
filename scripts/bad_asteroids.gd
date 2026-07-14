extends Node2D

var speed:int
const asteroid_bounds_threshold = 32
var can_be_catched = false
var should_process = false

func _check_color_blindness() -> void:
	if Optionshandler.colorblindness_option_enabled:
		$Sprite2D.texture = preload("res://textures_and_audios/badasteroid_blindness.png")
	else:
		$Sprite2D.texture = preload("res://textures_and_audios/badAsteroid.png")

func _ready() -> void:
	_check_color_blindness()

func _process(delta: float) -> void:
	if should_process:
		speed += 1
		position.x += (speed * ElapsedTimer.elapsedTime) * delta
		if position.x > (get_viewport_rect().size.x + asteroid_bounds_threshold):
			Signalbus.return_asteroid_to_pool.emit(self)
