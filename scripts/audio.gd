extends Node

var token = 0

func _play_eat_sound() -> void:
	match token:
		0:
			$Eat1.play()
		1:
			$Eat2.play()
		2:
			$Eat3.play()
	token = randi_range(0, 2)
	
func _play_death_sound() -> void:
	$Death.play()
	
func _play_select_sound() -> void:
	$Select.play()
	
func _play_idle_music() -> void:
	$Asteroid_Start.stop()
	$Asteroid_Loop.stop()
	if not $Asteroid_Idle.playing:
		$Asteroid_Idle.play()
	
func _play_start_music() -> void:
	$Asteroid_Idle.stop()
	$Asteroid_Start.play()
	
func _play_main_music() -> void:
	$Asteroid_Loop.play()

func _ready() -> void:
	Signalbus.play_eat_sound.connect(_play_eat_sound)
	Signalbus.play_death_sound.connect(_play_death_sound)
	Signalbus.play_select_sound.connect(_play_select_sound)
	Signalbus.play_idle_music.connect(_play_idle_music)
	Signalbus.play_start_music.connect(_play_start_music)
	Signalbus.game_over.connect(_play_idle_music)
	$Asteroid_Start.finished.connect(_play_main_music)
