extends Node

var colorBlindness = false

func _toggle_color_blindess() -> void:
	if not colorBlindness:
		colorBlindness = true
	else:
		colorBlindness = false
		
func _ready() -> void:
	Signalbus.toggle_blindness.connect(_toggle_color_blindess)
