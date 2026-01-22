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
	
func _ready() -> void:
	var backgroundInstance = preload("res://scenes/background.tscn").instantiate()
	add_child(backgroundInstance)
	$PlayButton/Button.pressed.connect(_start_game)
	$ExitButton/Button.pressed.connect(_exit_game)
	$ResetHighscore/Button.pressed.connect(_reset_highscore)
	$TutorialButton/Button.pressed.connect(_enter_tutorial)
	_change_highscore_label()
