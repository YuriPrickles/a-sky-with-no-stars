extends BaseRoom

func on_next_turn(room:Room):
	State.loaded_game.update_resources(5,0,0,0)
