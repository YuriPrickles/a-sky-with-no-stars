extends BaseRoom

func on_next_turn(room:Room):
	var pioneers:Array = State.loaded_game.assigned_pioneers.get(room)
	for p in pioneers:
		if p != null:
			var str_array = str_thresholds.keys()
			str_array.reverse()
			for st in str_array:
				if p.strength >= st:
					State.loaded_game.update_resources(0,str_thresholds[st],0,0)
					break
