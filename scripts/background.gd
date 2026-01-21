extends Node2D

@onready var far = $farStars
@onready var mid = $midStars
@onready var close = $closeStars

func _process(delta: float) -> void:
	far.scroll_offset.x -= (15 * ElapsedTimer.elapsedTime) * delta
	mid.scroll_offset.x -= (30 * ElapsedTimer.elapsedTime) * delta
	close.scroll_offset.x -= (50 * ElapsedTimer.elapsedTime) * delta
