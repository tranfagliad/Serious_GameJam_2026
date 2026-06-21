
//pause input
if objInputManager.pressed.escape {
	
	//run the logic
	if !global.gamePaused PauseActivate(); else PauseDeactivate();
	
}