extends Node2D

const padding_x = 200
const padding_y = 28

func _spawn_asteroid():
	var SpawnPosition = Vector2.ZERO
	SpawnPosition.x -= padding_x
	SpawnPosition.y = randi_range(padding_y, (int(get_viewport_rect().size.y) - padding_y))
	
	var asteroidInstance = preload("res://scenes/asteroids.tscn").instantiate()
	add_child(asteroidInstance)
	asteroidInstance.position = SpawnPosition
	
func _spawn_bad_asteroid():
	var SpawnPosition = Vector2.ZERO
	SpawnPosition.x -= padding_x
	SpawnPosition.y = randi_range(padding_y, (int(get_viewport_rect().size.y) - padding_y))
	
	var badAsteroidInstance = preload("res://scenes/badAsteroids.tscn").instantiate()
	add_child(badAsteroidInstance)
	badAsteroidInstance.position = SpawnPosition
	pass
	

func _ready() -> void:
	Signalbus.start_spawn_timer.emit()
	$SpawnTimer/AsteroidTimer.timeout.connect(_spawn_asteroid)
	$SpawnTimer/BadAsteroidTimer.timeout.connect(_spawn_bad_asteroid)
	Signalbus.start_elapsed_timer.emit()
	
	var playerInstance = preload("res://scenes/Player.tscn").instantiate()
	add_child(playerInstance)
	var scoreboardInstance = preload("res://scenes/scoreboard.tscn").instantiate()
	add_child(scoreboardInstance)
	var difficultyInstance = preload("res://scenes/difficulty_text.tscn").instantiate()
	add_child(difficultyInstance)
