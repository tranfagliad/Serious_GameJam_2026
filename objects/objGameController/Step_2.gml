//pause input
if objInputManager.pressed.escape {
	
	//exceptions
	var _exception1 = global.gameState == GameStateLevelComplete || global.gameState == GameStatePlayerDeath;
	var _exception2 = room == rmInit || room == rmMainMenu;
	var _exception = _exception1 || _exception2;
	
	//exceptions check
	if (!global.midTransition && !_exception) {
		
		if !global.gamePaused PauseActivate(); else PauseDeactivate();
		
	}
	
}