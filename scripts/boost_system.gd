extends Node

const regenRate = 20
const drainRate = 80
const boostMultiplier = 2
var boostCapacity = 100
var boostActive = false
var canRegen = false
var regenToken = 0

func _start_process():
	set_process(true)
	
func _start_regen_delay() -> void:
	regenToken += 1
	var token = regenToken
	await get_tree().create_timer(1).timeout
	if token == regenToken:
		canRegen = true

func _ready() -> void:
	set_process(false)
	Signalbus.start_boost_process.connect(_start_process)
	
func _process(delta: float) -> void:
	var boostPressed = Input.is_action_pressed("Boost")
	
	if boostPressed && not boostActive && boostCapacity > 0:
		boostActive = true
		canRegen = false
	if not boostPressed && boostActive:
		boostActive = false
		_start_regen_delay()
	if boostActive && boostCapacity == 0:
		boostActive = false
		_start_regen_delay()
	
	if boostActive:
		boostCapacity = clamp(boostCapacity - (drainRate * delta) , 0, 100)
	if not boostActive && canRegen:
		boostCapacity = clamp(boostCapacity + (regenRate * delta) , 0, 100)
