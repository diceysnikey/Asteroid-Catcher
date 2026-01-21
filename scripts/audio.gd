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

func _ready() -> void:
	Signalbus.play_eat_sound.connect(_play_eat_sound)
	Signalbus.play_death_sound.connect(_play_death_sound)
	Signalbus.play_select_sound.connect(_play_select_sound)
