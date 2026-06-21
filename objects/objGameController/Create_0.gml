#region debug
	
	//randomise();
	global.htmlActive = false;
	
	global.cheat = true;
	global.cheatcode = "bees";
	global.showDebugUI = false;

#endregion

#region state machine

	global.gamePaused = false;
	
	global.gameState = GameStateDefault;
	global.gameStatePrev = GameStateDefault;
	
	global.enemySpawnCd = 180;
	global.enemySpawnCdMax = 180;
	
#endregion

global.inventory = {
	papers: 0,
	computers: 0,
	staples: 0
};
