function GameStateDefault(){
	
	// countdown enemy spawn cooldown
	global.enemySpawnCd = Approach(global.enemySpawnCd, 0, 1);
	if global.enemySpawnCd <= 0 {
		global.enemySpawnCd = global.enemySpawnCdMax;
		var _enemyType = choose(objEnemyDefault, objEnemyDash, objEnemyTrap);
		var _spawn_count = instance_number(objEnemySpawn);
		if (_spawn_count > 0) {
			var _random_index = irandom(_spawn_count - 1);
			var _sp = instance_find(objEnemySpawn, _random_index);
			if (instance_exists(_sp)) {
				instance_create_layer(_sp.x, _sp.y, "Enemy", _enemyType);
			}
		}
	}
	
	// --- LEVEL COMPLETE TRIGGER ---
	if (global.enemyDefeated >= global.enemyDefeatedReq) {
		if (room == rmLevelOne || room == rmLevelTwo || room == rmLevelThree) {
			global.enemyDefeated = 0;
			
			// Initialize our upgrade wheel phase and variables inside objGameController
			with (objGameController) {
				wheelPhase = 0;
				wheelAngle = irandom(359); // Start at a random resting position
				wheelSpeed = 0;
			}
			
			// Lock down player and enemy state buffers
			with objPlayer playerStatePrev = playerState;
			with objEnemyParent enemyStatePrev = enemyState;
			
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
	global.gamePaused = true;
	

	with (objGameController) {
		
		switch (wheelPhase) {
			
			case WheelSpinPhase.WAITING:
				if (objInputManager.pressed.space) {
					wheelSpeed = random_range(25, 40); 
					wheelPhase = WheelSpinPhase.SPINNING;
				}
				break;
				
			case WheelSpinPhase.SPINNING:
				wheelAngle += wheelSpeed;
				wheelSpeed = Approach(wheelSpeed, 0, wheelFriction);
				
				if (wheelAngle >= 360)  { wheelAngle -= 360; }
				
				// Check if the wheel has ground to a complete halt
				if (wheelSpeed <= 0) {
					wheelPhase = WheelSpinPhase.SPIN_COMPLETE;
				}
				break;
				
			case WheelSpinPhase.SPIN_COMPLETE:
				if (objInputManager.pressed.space) {
					global.gamePaused = false;
					
					// Proceed seamlessly to the target room routing matrix
					switch room {
						case rmLevelOne:
							TransitionStart(rmLevelTwo, sqFadeOut, sqFadeIn, global.playerPosLevel2[0], global.playerPosLevel2[1], GameStateDefault);
							break;
							
						case rmLevelTwo:
							TransitionStart(rmLevelThree, sqFadeOut, sqFadeIn, global.playerPosLevel3[0], global.playerPosLevel3[1], GameStateDefault);
							break;
							
						case rmLevelThree:
							TransitionStart(rmBossLevel, sqFadeOut, sqFadeIn, global.playerPosBossLevel[0], global.playerPosBossLevel[1], GameStateDefault);
							break;
					}
					
					global.enemySpawnPoints = [];
				}
				break;
		}
	}
}
