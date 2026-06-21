#region cheats
	
	//input cheatcode
	if (keyboard_lastchar == "b") keyboard_string = keyboard_lastchar;
	if (keyboard_string == global.cheatcode) {
		global.cheat = !global.cheat;
		keyboard_string = "";
	}
	
	//cheat commands
	if global.cheat {
		
		if keyboard_check_pressed(ord("R")) game_restart();
		if keyboard_check_pressed(vk_tab) global.showDebugUI = !global.showDebugUI;
		
	}

#endregion