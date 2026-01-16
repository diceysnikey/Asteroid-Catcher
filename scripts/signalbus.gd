extends Node
@warning_ignore_start("unused_signal")

# Asteroid Logic
signal trigger_mouth(asteroid)
signal check_trigger(asteroid)
signal eat_asteroid(asteroid)
signal game_over()
signal scored_point(newScore: int)

# Menu Logic
signal playbutton_pressed()
signal reset_highscore()
signal exit_game()
signal restart_game()

# Misc
signal start_spawn_timer()
signal start_elapsed_timer()
signal increase_difficulty()
