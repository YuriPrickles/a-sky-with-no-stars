extends BaseRoom

func on_next_turn():
	State.loaded_game.update_resources(5,0,0,0)
