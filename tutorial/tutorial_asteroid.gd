extends Node2D

const speed = 200
const outOfViewPadding = 32
var triggeredMouth = false
var toggleProcess = false

func _ChangeMouthTrigger(asteroid: Node2D) -> void:
	if asteroid == self && triggeredMouth == false:
			triggeredMouth = true
	
func _CheckMouthTrigger(asteroid: Node2D) -> void:
	if asteroid == self && triggeredMouth == true:
		Signalbus.tutorial_asteroid_collected.emit()
		Signalbus.eat_asteroid.emit(self)
	
func _ready() -> void:
	Signalbus.trigger_mouth.connect(_ChangeMouthTrigger)
	Signalbus.check_trigger.connect(_CheckMouthTrigger)
	position.x = -200
	position.y = (get_viewport_rect().size.y / 2) / 2
	toggleProcess = true

func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > (get_viewport_rect().size.x + outOfViewPadding):
		await get_tree().create_timer(1.3).timeout
		position.x = -200
