extends Node

func change_player_sprite_mouth(string):
	var player_sprite:AnimatedSprite2D = get_node(
	"/root/Director/Spawner/Player/AnimatedSprite2D")
	player_sprite.play(string)
	var player_trail:CPUParticles2D = get_node("/root/Director/Spawner/Player/CPUParticles2D")
	player_trail.texture = load(
		"res://textures_and_audios/diceboy_" + string + ".png")
