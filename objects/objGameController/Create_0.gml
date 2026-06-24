#region debug
	
	//randomise();
	global.htmlActive = false;
	
	global.cheat = true;
	global.cheatcode = "bees";
	global.showDebugUI = false;

#endregion

#region sound
	
	global.soundVolume = 0.5;
	global.musicVolume = 0.5;
	
#endregion

#region game data
	
	global.screenShakeActive = true;
	global.dataDialogue = DataCreateDialogue();
	
#endregion

#region state machine

	global.gamePaused = false;
	
	global.gameState = GameStateDefault;
	global.gameStatePrev = GameStateDefault;
	
	global.enemySpawnCd = 180;
	global.enemySpawnCdMax = 180;
	
	global.enemyDefeated = 0;
	global.enemyDefeatedReq = 15;
	
#endregion

#region inventory data
	
	global.inventory = {
		papers: 0,
		computers: 0,
		staplers: 0
	};

	global.inventoryVisuals = {
	    papers: [],
	    computers: [],
	    staplers: []
	};
	
#endregion
