extends Node2D

const padding_x = 200
const padding_y = 28
var asteroidPool = []
var badAsteroidPool = []

func _instantiate_game() -> void:
	var playerInstance = preload("res://scenes/Player.tscn").instantiate()
	add_child(playerInstance)
	var scoreboardInstance = preload("res://scenes/scoreboard.tscn").instantiate()
	add_child(scoreboardInstance)
	var difficultyInstance = preload("res://scenes/difficulty_text.tscn").instantiate()
	add_child(difficultyInstance)
	
func _instantiate_asteroid_pool() -> void:
	for i in range(5):
		var asteroid = preload("res://scenes/asteroids.tscn").instantiate()
		asteroid.visible = false
		add_child(asteroid)
		asteroidPool.append(asteroid)
	for i in range(5):
		var badAsteroid = preload("res://scenes/badAsteroids.tscn").instantiate()
		badAsteroid.visible = false
		add_child(badAsteroid)
		badAsteroidPool.append(badAsteroid)

func _spawn_asteroid():
	for asteroid in asteroidPool.filter(func(a): return not a.visible):
		var SpawnPosition = Vector2.ZERO
		SpawnPosition.x -= padding_x
		SpawnPosition.y = randi_range(padding_y, (int(get_viewport_rect().size.y) - padding_y))
		asteroid.position = SpawnPosition
		asteroid.visible = true
		asteroid.toggleProcess = true
		break

func _spawn_bad_asteroid():
	for badAsteroid in badAsteroidPool.filter(func(a): return not a.visible):
		var SpawnPosition = Vector2.ZERO
		SpawnPosition.x -= padding_x
		SpawnPosition.y = randi_range(padding_y, (int(get_viewport_rect().size.y) - padding_y))
		badAsteroid.position = SpawnPosition
		badAsteroid.visible = true
		badAsteroid.toggleProcess = true
		badAsteroid.speed = 200
		break
	
func _return_asteroid_to_pool(asteroid):
	asteroid.visible = false
	asteroid.toggleProcess = false
	asteroid.position.y = get_viewport_rect().size.y * 2
	
func _ready() -> void:
	Signalbus.start_spawn_timer.emit()
	$SpawnTimer/AsteroidTimer.timeout.connect(_spawn_asteroid)
	$SpawnTimer/BadAsteroidTimer.timeout.connect(_spawn_bad_asteroid)
	Signalbus.return_asteroid_to_pool.connect(_return_asteroid_to_pool)
	Signalbus.start_elapsed_timer.emit()
	_instantiate_game()
	_instantiate_asteroid_pool()
