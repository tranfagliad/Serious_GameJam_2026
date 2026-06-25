//initialize game state depending on the room
switch room {
	
	//intro at the start of first level
	case rmLevelOne: {
		
		instance_create_layer(global.playerPosLevel1[0], global.playerPosLevel1[1], "System", oCutsceneAnchor);
		DialogueStart(DLG_SEQ_INTRO, GameStateDefault);
		
	} break;
	
	case rmLevelTwo: {
		
		DialogueStart(DLG_SEQ_LVL_TWO, GameStateDefault);
		
	} break;
	
	
	case rmLevelThree: {
		
		DialogueStart(DLG_SEQ_LVL_THREE, GameStateDefault);
		
	} break;
	
	case rmBossLevel: {
		
		instance_create_layer(global.playerPosBossLevel[0], global.playerPosBossLevel[1], "System", oCutsceneAnchor);
		DialogueStart(DLG_SEQ_LVL_BOSS, GameStateDefault);
		
	} break;
	
	//add outro later
	
}