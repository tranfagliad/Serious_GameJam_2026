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
	global.cutsceneSkip = false;
	global.dataDialogue = DataCreateDialogue();
	
	global.playerPosCheckpoint = [256, 256];
	global.playerPosLevel1 = [271, 255];
	global.playerPosLevel2 = [512, 256];
	global.playerPosLevel3 = [352, 224];
	global.playerPosBossLevel = [992, 1024];
	
	// used for keeping track between transitions
	global.playerHp = 3;	
	global.playerSpeed = 4;
	global.playerDashPower = 1;
	PlayerStatsReset();
	
	global.paperReductionAmount = 2;
	
#endregion

#region state machine

	global.gamePaused = false;
	global.midTransition = false;
	
	global.gameState = GameStateDefault;
	global.gameStatePrev = GameStateDefault;
	
	global.enemySpawnCd = 180;
	global.enemySpawnCdMax = 180;
	
	global.enemyDefeated = 0;
	global.enemyDefeatedReq = 10;
	
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


// Wheel Spins
wheelPhase = WheelSpinPhase.WAITING;
wheelAngle = 0;
wheelSpeed = 0;
wheelFriction = 0.15;
