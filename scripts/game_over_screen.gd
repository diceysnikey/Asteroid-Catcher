extends Control

func _exit_game() -> void:
	Signalbus.exit_game.emit()

func _restart_game() -> void:
	Signalbus.play_select_sound.emit()
	Signalbus.restart_game.emit()

func _ready() -> void:
	$ExitButton/Button.pressed.connect(_exit_game)
	$RestartButton/Button.pressed.connect(_restart_game)
	$HighscoreText/Label.text = ("Highscore: " + str(HighscoreManager.highscore))
