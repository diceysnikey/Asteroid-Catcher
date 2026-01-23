extends Control

func _exit_game() -> void:
	Signalbus.exit_game.emit()

func _back_to_menu() -> void:
	Signalbus.play_select_sound.emit()
	Signalbus.back_to_menu.emit()

func _ready() -> void:
	$ExitButton/Button.pressed.connect(_exit_game)
	$MenuButton/Button.pressed.connect(_back_to_menu)
	$HighscoreText/Label.text = ("Highscore: " + str(HighscoreManager.highscore))
