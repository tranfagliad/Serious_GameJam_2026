function GameStateDefault(){
	
	// countdown enemy spawn cooldown
	global.enemySpawnCd = Approach(global.enemySpawnCd, 0, 1);
	if global.enemySpawnCd <= 0 {
		
		// refresh cd
		global.enemySpawnCd = global.enemySpawnCdMax;
		
		// choose an enemy
		var _enemyType = choose(objEnemyDefault, objEnemyDash, objEnemyTrap);
		
		// Count the spawn points directly present in the current room
		var _spawn_count = instance_number(objEnemySpawn);
		
		if (_spawn_count > 0) {
			var _random_index = irandom(_spawn_count - 1);
			var _sp = instance_find(objEnemySpawn, _random_index);
			
			if (instance_exists(_sp)) {
				instance_create_layer(_sp.x, _sp.y, "Enemy", _enemyType);
			}
		}
	}
	
	// LEVEL COMPLETE TRIGGER (Levels 1, 2, and 3)
	if (global.enemyDefeated >= global.enemyDefeatedReq) {
		
		// Check if we are on a standard leveling floor
		if (room == rmLevelOne || room == rmLevelTwo || room == rmLevelThree) {
			
			global.enemyDefeated = 0;
			
			// Initialize freeze timer (120 frames = 2 seconds)
			global.levelCompleteTimer = 120; 
			
			// Lock down player and enemy state buffers
			with objPlayer playerStatePrev = playerState;
			with objEnemyParent enemyStatePrev = enemyState;
			
			// Transfer state pointer to the Level Complete sequence
			global.gameState = GameStateLevelComplete;
		}
	}
}









function GameStatePaused(){
	
	
	
}







function GameStateDialogue(){
	
	//check if textbox is removed
	if !instance_exists(objTextbox) {
		DialogueClean();
		
		//move from dialogue
		global.gameState = global.gameStateTarget;
		
		//unlock other state machines
		with objPlayer playerState = playerStatePrev;
		with objEnemyParent enemyState = enemyStatePrev;
	}
	
}

function GameStateTransition(){
	
	//check when transition is over, then move from this state
	if !global.midTransition global.gameState = global.gameStateTarget;
		
}


function GameStateLevelComplete(){
	// Freeze physics & inputs via existing global check
	global.gamePaused = true;
	
	// Tick down freeze duration
	global.levelCompleteTimer--;
	
	if (global.levelCompleteTimer <= 0) {
		global.gamePaused = false; // Lift global pause flag for the next map load
		
		// Process spatial room transitions cleanly
		switch room {
			case rmLevelOne:
				TransitionStart(rmLevelTwo, sqFadeOut, sqFadeIn, global.playerPosLevel2[0], global.playerPosLevel2[1], GameStateDefault);
				break;
				
			case rmLevelTwo:
				TransitionStart(rmLevelThree, sqFadeOut, sqFadeIn, global.playerPosLevel3[0], global.playerPosLevel3[1], GameStateDefault);
				break;
				
			case rmLevelThree:
				// Router goes straight to Boss floor after Level 3!
				TransitionStart(rmBossLevel, sqFadeOut, sqFadeIn, global.playerPosBossLevel[0], global.playerPosBossLevel[1], GameStateDefault);
				break;
		}
		
		// Flush old spawn points list so the newly loaded room updates cleanly
		global.enemySpawnPoints = [];
	}
}





