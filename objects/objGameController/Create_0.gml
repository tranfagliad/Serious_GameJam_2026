#region debug
	
	//randomise();
	global.htmlActive = false;
	
	global.cheat = true;
	global.cheatcode = "bees";
	global.showDebugUI = false;

#endregion

#region pause
	
	//pausing variables
	global.gamePaused = false;
	global.unpausingInputLock = false;	//using this flag to not trigger input the same frame as unpausing
	global.unpausingCd = 0;
	global.unpausingCdMax = 1;			//1 frame of unpausing buffer
	
#endregion

#region state machine
	
	global.gameState = GameStateDefault;
	global.gameStatePrev = GameStateDefault;
	
#endregion

global.inventory = {
	papers: 0,
	computers: 0,
	staples: 0
};
