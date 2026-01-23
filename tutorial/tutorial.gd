extends Node2D

func _show_move_keys() -> void:
	$UpIcon.visible = true
	$DownIcon.visible = true
	$BoostIcon.visible = true
	$FullscreenIcon.visible = true
	await get_tree().create_timer(4.5).timeout
	$UpIcon.visible = false
	$DownIcon.visible = false
	$BoostIcon.visible = false
	$FullscreenIcon.visible = false
	
func _collect_asteroid() -> void:
	$CollectText.visible = true
	var asteroid = preload("res://tutorial/tutorialAsteroid.tscn").instantiate()
	add_child(asteroid)

func _dodge_asteroid() -> void:
	$CollectText.visible = false
	await get_tree().create_timer(1).timeout
	$DodgeText.visible = true
	var badAsteroid = preload("res://tutorial/tutorialBadAsteroid.tscn").instantiate()
	add_child(badAsteroid)
	
func _dodge_failed() -> void:
	$DodgeFailOverlay.visible = true
	Audio._play_death_sound()
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	$DodgeFailOverlay.visible = false
	
func _dodge_success() -> void:
	$DodgeText.visible = false
	$GoodJobText.visible = true
	$ReturningtoMenuText.visible = true
	await get_tree().create_timer(3).timeout
	Signalbus.back_to_menu.emit()
	
func _ready() -> void:
	var playerInstance = preload("res://scenes/Player.tscn").instantiate()
	add_child(playerInstance)
	var backgroundInstance = preload("res://scenes/background.tscn").instantiate()
	add_child(backgroundInstance)
	await _show_move_keys()
	_collect_asteroid()
	Signalbus.tutorial_asteroid_collected.connect(_dodge_asteroid)
	Signalbus.tutorial_dodge_failed.connect(_dodge_failed)
	Signalbus.tutorial_asteroid_dodged.connect(_dodge_success)
