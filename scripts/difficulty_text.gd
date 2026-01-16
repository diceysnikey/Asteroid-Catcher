extends CanvasLayer

var difficulty = 0

func _increase_difficulty_text() -> void:
	difficulty += 1
	$Label.text = "Difficulty: " + str(difficulty)

func _ready() -> void:
	_increase_difficulty_text()
	Signalbus.increase_difficulty.connect(_increase_difficulty_text)
