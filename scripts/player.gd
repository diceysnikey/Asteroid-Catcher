extends CharacterBody2D

const speed = 500
const accel = speed * 8
var score: int = 0


func _on_outerCollision_entered(area: Area2D) -> void:
	$AnimatedSprite2D.play("open")
	var asteroid = area.get_parent()
	Signalbus.trigger_mouth.emit(asteroid)

func _on_innerCollision_entered(area: Area2D) -> void:
	var asteroid = area.get_parent()
	Signalbus.check_trigger.emit(asteroid)
	
func _on_badCollision_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("BadAsteroids"):
		Signalbus.game_over.emit()

func _eat_asteroid(asteroid) -> void:
	$AnimatedSprite2D.play("closed")
	score += 1
	Signalbus.scored_point.emit(score)
	Signalbus.return_asteroid_to_pool.emit(asteroid)
	
	
func _ready() -> void:
	$OuterCollision.area_entered.connect(_on_outerCollision_entered)
	$InnerCollision.area_entered.connect(_on_innerCollision_entered)
	$BadCollision.area_entered.connect(_on_badCollision_entered)
	Signalbus.eat_asteroid.connect(_eat_asteroid)
	
	$Walls.top_level = true
	position.y = get_viewport_rect().size.y / 2
	position.x = get_viewport_rect().size.x - ($WallCollider.shape.get_rect().size.x / 2)
	
func _physics_process(delta: float) -> void:
	var distance = get_global_mouse_position().y - position.y
	var targetVelocity = Vector2.ZERO
	targetVelocity.y = clamp(distance, -speed, speed)
	
	velocity = velocity.move_toward(targetVelocity, accel * delta)
	move_and_slide()
