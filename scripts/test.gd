extends Node

var last_time = 0.0

func _process(_delta):
	var now = Time.get_ticks_msec()
	if last_time != 0:
		var diff = now - last_time
		if diff > 20:  # 50 FPS frame or higher is suspect
			print("possible stutter frame: ", now)
	last_time = now
