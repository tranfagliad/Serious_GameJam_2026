//initialize game state depending on the room
switch room {
	
	//intro at the start of first level
	case rmLevelOne: {
		
		instance_create_layer(global.playerPosLevel1[0], global.playerPosLevel1[1], "System", oCutsceneAnchor);
		if global.cutsceneSkip global.gameState = GameStateDefault; else DialogueStart(DLG_SEQ_INTRO, GameStateDefault);
		global.enemyDefeatedReqCurrent = global.enemyDefeatedReqLevel1;
		global.enemySpawnCdMaxCurrent = global.enemySpawnCdMaxLevel1;
		
		AmbientChange(AMBIENT_MUSIC, bgmLevel1);
		AmbientChange(AMBIENT_OFFICE, bgmAmbientOffice, 30);
		
	} break;
	
	case rmLevelTwo: {
		
		instance_create_layer(global.playerPosLevel2[0], global.playerPosLevel2[1], "System", oCutsceneAnchor);
		if global.cutsceneSkip global.gameState = GameStateDefault; else DialogueStart(DLG_SEQ_LVL_TWO, GameStateDefault);
		global.enemyDefeatedReqCurrent = global.enemyDefeatedReqLevel2;
		global.enemySpawnCdMaxCurrent = global.enemySpawnCdMaxLevel2;
		
		AmbientChange(AMBIENT_MUSIC, bgmLevel1);
		AmbientChange(AMBIENT_OFFICE, bgmAmbientOffice, 30);
		
	} break;
	
	
	case rmLevelThree: {
		
		instance_create_layer(global.playerPosLevel3[0], global.playerPosLevel3[1], "System", oCutsceneAnchor);
		if global.cutsceneSkip global.gameState = GameStateDefault; else DialogueStart(DLG_SEQ_LVL_THREE, GameStateDefault);
		global.enemyDefeatedReqCurrent = global.enemyDefeatedReqLevel3;
		global.enemySpawnCdMaxCurrent = global.enemySpawnCdMaxLevel3;
		
		AmbientChange(AMBIENT_MUSIC, bgmLevel1);
		AmbientChange(AMBIENT_OFFICE, bgmAmbientOffice, 30);
		
	} break;
	
	case rmBossLevel: {
		
		instance_create_layer(global.playerPosBossLevel[0], global.playerPosBossLevel[1], "System", oCutsceneAnchor);
		if global.cutsceneSkip global.gameState = GameStateDefault; else DialogueStart(DLG_SEQ_LVL_BOSS, GameStateDefault);
		global.enemyDefeatedReqCurrent = global.enemyDefeatedReqLevelBoss;
		global.enemySpawnCdMaxCurrent = global.enemySpawnCdMaxLevelBoss;
		
		AmbientChange(AMBIENT_MUSIC, bgmBossIntro);
		AmbientChange(AMBIENT_OFFICE, bgmAmbientOffice, 30);
		
	} break;
	
	//add outro later
	
}