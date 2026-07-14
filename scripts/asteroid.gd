extends Node2D

const speed = 200
const asteroid_bounds_threshold = 32
var can_be_catched = false
var should_process = false

func _check_color_blindness() -> void:
	if Optionshandler.colorblindness_option_enabled:
		$Sprite2D.texture = preload("res://textures_and_audios/asteroid_blindness.png")
	else:
		$Sprite2D.texture = preload("res://textures_and_audios/asteroid.png")

func _ChangeMouthTrigger(asteroid: Node2D) -> void:
	if asteroid == self && can_be_catched == false:
			can_be_catched = true
	
func _CheckMouthTrigger(asteroid: Node2D) -> void:
	if asteroid == self && can_be_catched == true:
		Signalbus.eat_asteroid.emit(self)
	
	
func _ready() -> void:
	Signalbus.trigger_mouth.connect(_ChangeMouthTrigger)
	Signalbus.check_trigger.connect(_CheckMouthTrigger)
	_check_color_blindness()

func _process(delta: float) -> void:
	if should_process:
		position.x += (speed * ElapsedTimer.elapsedTime) * delta
		if position.x > (get_viewport_rect().size.x + asteroid_bounds_threshold):
			Signalbus.return_asteroid_to_pool.emit(self)
