extends Node

var rawTime = 0.80
var elapsedTime:float
var timerTriggered = false

func _trigger_timer() -> void:
	timerTriggered = true

func _reset_timer() -> void:
	rawTime = 0.80
	timerTriggered = false

func _ready() -> void:
	Signalbus.start_elapsed_timer.connect(_trigger_timer)
	Signalbus.game_over.connect(_reset_timer)

func _process(delta: float) -> void:
	if timerTriggered:
		rawTime += delta * 0.05
		elapsedTime = snapped(rawTime, 0.01)
