extends Node

const boundary = 0.4
const asteroidTimerDecrease = 0.1
const badAsteroidTimerDecrease = 0.4
var lastStep = ElapsedTimer.rawTime + boundary

func _set_start_time() -> void:
	$AsteroidTimer.wait_time = 2
	$BadAsteroidTimer.wait_time = 4
	$AsteroidTimer.start()
	$BadAsteroidTimer.start()

func _decrease_time() -> void:
	$AsteroidTimer.wait_time = clamp($AsteroidTimer.wait_time - asteroidTimerDecrease, 0.8, INF)
	$BadAsteroidTimer.wait_time = clamp($BadAsteroidTimer.wait_time- badAsteroidTimerDecrease, 0.6, INF)
	Signalbus.increase_difficulty.emit()

func _ready() -> void:
	Signalbus.start_spawn_timer.connect(_set_start_time)
	
func _process(_delta: float) -> void:
	if ElapsedTimer.elapsedTime > lastStep:
		_decrease_time()
		lastStep += boundary
