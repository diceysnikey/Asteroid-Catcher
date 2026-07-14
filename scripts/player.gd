extends CharacterBody2D

#@onready var trail = $CPUParticles2D
const speed = 2000
var score: int = 0

func _on_outerCollision_entered(area: Area2D) -> void:
	var asteroid = area.get_parent()
	if not asteroid.is_in_group("BadAsteroids") and not asteroid.is_in_group("BadTutorial"):
		Signalbus.change_player_sprite_mouth.emit("open")
		Signalbus.trigger_mouth.emit(asteroid)

func _on_innerCollision_entered(area: Area2D) -> void:
	var asteroid = area.get_parent()
	Signalbus.check_trigger.emit(asteroid)
	
func _on_badCollision_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("BadAsteroids"):
		Signalbus.play_death_sound.emit()
		Signalbus.game_over.emit()

func _eat_asteroid(asteroid) -> void:
	Signalbus.play_eat_sound.emit()
	Signalbus.change_player_sprite_mouth.emit("closed")
	score += 1
	Signalbus.scored_point.emit(score)
	if not asteroid.is_in_group("Tutorial"):
		Signalbus.return_asteroid_to_pool.emit(asteroid)
	else:
		asteroid.queue_free()
		
func _ready() -> void:
	$OuterCollision.area_entered.connect(_on_outerCollision_entered)
	$InnerCollision.area_entered.connect(_on_innerCollision_entered)
	$BadCollision.area_entered.connect(_on_badCollision_entered)
	Signalbus.eat_asteroid.connect(_eat_asteroid)
	
	$Walls.top_level = true
	position.y = get_viewport_rect().size.y / 2
	position.x = get_viewport_rect().size.x - ($WallCollider.shape.get_rect().size.x / 2)
	
func _process(_delta: float) -> void:
	var mouse_target_y = get_global_mouse_position().y
	var viewport_border_y = get_viewport_rect().size.y
	var player_size = $WallCollider.shape.get_rect().size
	#var distance_to_target = int(mouse_target.y - global_position.y)
	#if distance_to_target > 0:
	#	velocity.y = speed * 1
	#elif distance_to_target < 0:
	#	velocity.y = speed * -1
	#if abs(distance_to_target) < speed * delta:
	#	velocity.y = 0
	#move_and_slide()
	#trail.texture = $AnimatedSprite2D.sprite_frames
	global_position.y = clamp(
		mouse_target_y, player_size.y/2, 
		viewport_border_y - (player_size.y/2))
