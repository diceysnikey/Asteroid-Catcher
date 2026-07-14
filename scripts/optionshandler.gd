extends Node

var colorblindness_option_enabled = false
var music_option_enabled = true

func _toggle_color_blindess() -> void:
	colorblindness_option_enabled = !colorblindness_option_enabled

func _toggle_music() -> void:
	music_option_enabled = !music_option_enabled

func _ready() -> void:
	Signalbus.toggle_color_blindness_option.connect(_toggle_color_blindess)
	Signalbus.toggle_music_option.connect(_toggle_music)
