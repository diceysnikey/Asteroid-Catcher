extends Node2D

var speed = 200
const outOfViewPadding = 32
var triggeredMouth = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	speed += 1
	position.x += (speed * ElapsedTimer.elapsedTime) * delta
	
	if position.x > (get_viewport_rect().size.x + outOfViewPadding):
		queue_free()
