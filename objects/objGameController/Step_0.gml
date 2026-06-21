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

//global state machine
global.gameState();

//fullscreen
if !global.htmlActive {
	if objInputManager.pressed.fullscreen window_set_fullscreen(!window_get_fullscreen());
}