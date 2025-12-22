extends BaseRoom

func on_next_turn(room:Room):
	var pioneers:Array = State.loaded_game.assigned_pioneers.get(room)
	for p in pioneers:
		if p != null:
			var dex_array = dex_thresholds.keys()
			dex_array.reverse()
			for dex in dex_array:
				if p.dexterity >= dex:
					State.loaded_game.update_resources(dex_thresholds[dex],0,0,0)
					break
