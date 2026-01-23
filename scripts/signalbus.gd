extends Node
@warning_ignore_start("unused_signal")

# Asteroid Logic
signal trigger_mouth(asteroid)
signal check_trigger(asteroid)
signal eat_asteroid(asteroid)
signal return_asteroid_to_pool(asteroid)
signal game_over()
signal scored_point(newScore: int)

# Menu Logic
signal playbutton_pressed()
signal reset_highscore()
signal exit_game()
signal restart_game()
signal toggle_blindness()

# Audio
signal play_eat_sound()
signal play_death_sound()
signal play_select_sound()
signal play_idle_music()
signal play_start_music()

# Tutorial
signal enter_tutorial()
signal tutorial_asteroid_collected()
signal tutorial_asteroid_dodged()
signal tutorial_dodge_failed()

# Misc
signal start_spawn_timer()
signal start_elapsed_timer()
signal increase_difficulty()
signal start_boost_process()
