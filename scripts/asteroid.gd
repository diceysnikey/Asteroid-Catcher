extends Node2D

const speed = 200
const outOfViewPadding = 32
var triggeredMouth = false
var toggleProcess = false

func _check_color_blindness() -> void:
	if BlindnessToggle.colorBlindness:
		$Sprite2D.texture = preload("res://textures_and_audios/asteroid_blindness.png")
	else:
		$Sprite2D.texture = preload("res://textures_and_audios/asteroid.png")

func _ChangeMouthTrigger(asteroid: Node2D) -> void:
	if asteroid == self && triggeredMouth == false:
			triggeredMouth = true
	
func _CheckMouthTrigger(asteroid: Node2D) -> void:
	if asteroid == self && triggeredMouth == true:
		Signalbus.eat_asteroid.emit(self)
	
	
func _ready() -> void:
	Signalbus.trigger_mouth.connect(_ChangeMouthTrigger)
	Signalbus.check_trigger.connect(_CheckMouthTrigger)
	_check_color_blindness()

func _process(delta: float) -> void:
	if toggleProcess:
		position.x += (speed * ElapsedTimer.elapsedTime) * delta
		if position.x > (get_viewport_rect().size.x + outOfViewPadding):
			Signalbus.return_asteroid_to_pool.emit(self)
