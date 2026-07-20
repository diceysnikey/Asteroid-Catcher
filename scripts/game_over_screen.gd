extends Control

func _back_to_menu() -> void:
	Audiohandler._play_select_sound()
	Director._setup_menu()

func _restart_round() -> void:
	Audiohandler._play_select_sound()
	Director._restart_round()

func _exit_game() -> void:
	Audiohandler._play_select_sound()
	Director._exit_game()

func _ready() -> void:
	$MenuButton/Button.pressed.connect(_back_to_menu)
	$RestartButton/Button.pressed.connect(_restart_round)
	$ExitButton/Button.pressed.connect(_exit_game)
	$HighscoreText/Label.text = ("Highscore: " + str(Scorehandler.highscore))
