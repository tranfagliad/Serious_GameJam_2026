//initialize game state depending on the room
switch room {
	
	//intro at the start of first level
	case rmLevelOne: {
		
		instance_create_layer(global.playerPosLevel1[0], global.playerPosLevel1[1], "System", oCutsceneAnchor);
		DialogueStart(DLG_SEQ_INTRO, GameStateDefault);
		global.enemyDefeatedReqCurrent = global.enemyDefeatedReqLevel1;
		global.enemySpawnCdMaxCurrent = global.enemySpawnCdMaxLevel1;
		
	} break;
	
	case rmLevelTwo: {
		
		DialogueStart(DLG_SEQ_LVL_TWO, GameStateDefault);
		global.enemyDefeatedReqCurrent = global.enemyDefeatedReqLevel2;
		global.enemySpawnCdMaxCurrent = global.enemySpawnCdMaxLevel2;
		
	} break;
	
	
	case rmLevelThree: {
		
		DialogueStart(DLG_SEQ_LVL_THREE, GameStateDefault);
		global.enemyDefeatedReqCurrent = global.enemyDefeatedReqLevel3;
		global.enemySpawnCdMaxCurrent = global.enemySpawnCdMaxLevel3;
		
	} break;
	
	case rmBossLevel: {
		
		instance_create_layer(global.playerPosBossLevel[0], global.playerPosBossLevel[1], "System", oCutsceneAnchor);
		DialogueStart(DLG_SEQ_LVL_BOSS, GameStateDefault);
		global.enemyDefeatedReqCurrent = global.enemyDefeatedReqLevelBoss;
		global.enemySpawnCdMaxCurrent = global.enemySpawnCdMaxLevelBoss;
		
	} break;
	
	//add outro later
	
}