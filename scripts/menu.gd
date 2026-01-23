extends Control

func _start_game() -> void:
		var background = get_node("Background")
		background.queue_free()
		Signalbus.playbutton_pressed.emit()
		queue_free()
		
func _exit_game() -> void:
	Signalbus.exit_game.emit()
	
func _enter_tutorial() -> void:
	Signalbus.enter_tutorial.emit()
	queue_free()

func _reset_highscore() -> void:
	Signalbus.reset_highscore.emit()
	_change_highscore_label()
	
func _change_highscore_label() -> void:
	$HighScoreText/Label.text = ("Highscore: " + str(HighscoreManager.highscore))
	
func _toggle_color_blindness() -> void:
	Signalbus.toggle_blindness.emit()
	if BlindnessToggle.colorBlindness:
		$ColorBlindnessToggle/ColorRect.color = Color.from_rgba8(84, 193, 125, 120)
	else:
		$ColorBlindnessToggle/ColorRect.color = Color.from_rgba8(130, 46, 36, 120)		
	
func _ready() -> void:
	var backgroundInstance = preload("res://scenes/background.tscn").instantiate()
	add_child(backgroundInstance)
	$PlayButton/Button.pressed.connect(_start_game)
	$ExitButton/Button.pressed.connect(_exit_game)
	$ResetHighscore/Button.pressed.connect(_reset_highscore)
	$TutorialButton/Button.pressed.connect(_enter_tutorial)
	$ColorBlindnessToggle/Button.pressed.connect(_toggle_color_blindness)
	_change_highscore_label()
