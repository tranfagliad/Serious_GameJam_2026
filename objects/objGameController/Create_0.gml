#region debug
	
	randomise();
	global.cheat = false;
	global.cheatcode = "bees";
	global.showDebugUI = false;

#endregion

#region sound
	
	global.soundVolume = 0.5;
	global.musicVolume = 0.5;
	
	global.ambient = {};
	
#endregion

#region game data
	
	global.cutsceneSkip = false;
	global.screenShakeActive = true;
	global.ambientOfficeActive = true;
	global.ambientTornadoActive = false;
	global.sfxTextActive = true;
	
	global.dataDialogue = DataCreateDialogue();
	
	global.playerPosCheckpoint	= [256, 256];
	global.playerPosLevel1		= [271, 255];
	global.playerPosLevel2		= [1756, 2638];
	global.playerPosLevel3		= [320, 192];
	global.playerPosBossLevel	= [992, 1024];
	
	// used for keeping track between transitions
	PlayerStatsReset();
	global.paperReductionAmount = 5;
	
	global.playerFlashColor = c_orange;
	global.playerHitColor = c_red;
	global.enemyHitColor = c_aqua;
	
	
#endregion

#region state machine

	global.gamePaused = false;
	global.midTransition = false;
	
	global.gameState = GameStatePaused;
	global.gameStatePrev = GameStatePaused;
	
	global.enemySpawnCd = 180;
	global.enemySpawnCdMaxCurrent	= 150;
	global.enemySpawnCdMaxLevel1	= 150;
	global.enemySpawnCdMaxLevel2	= 120;
	global.enemySpawnCdMaxLevel3	= 90;
	global.enemySpawnCdMaxLevelBoss = 180;
	
	
	global.enemyDefeated = 0;
	global.enemyDefeatedReqCurrent		= 10;
	global.enemyDefeatedReqLevel1		= 15;
	global.enemyDefeatedReqLevel2		= 20;
	global.enemyDefeatedReqLevel3		= 25;
	global.enemyDefeatedReqLevelBoss	= 0;
	
	global.bossDefeated = false;
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


#region Wheel Spins

	wheelPhase = WheelSpinPhase.WAITING;
	wheelAngle = 0;
	wheelSpeed = 0;
	wheelFriction = 0.15;
	wheelScale = 0;
	
#endregion