function GameStateDefault(){
	
	// countdown enemy spawn cooldown
	global.enemySpawnCd = Approach(global.enemySpawnCd, 0, 1);
	if global.enemySpawnCd <= 0 {
		global.enemySpawnCd = global.enemySpawnCdMaxCurrent;
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
	switch room {
		//normal levels
		default: {
			if (global.enemyDefeated >= global.enemyDefeatedReqCurrent) {
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
				
				//move to wheel
				global.gameState = GameStateLevelComplete;
			}
		} break;
		
		//this actually should trigger during boss death animation (within enemy death trigger)
		//but here is a precaution
		case rmBossLevel: {
			if !instance_exists(objEnemyBoss) DialogueStart(DLG_SEQ_OUTRO, GameStateCredits);
		} break;
		
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


function GameStateCredits(){
	
	//maybe
	
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
				
				if (wheelAngle >= FOURTH_QUADRANT)  { wheelAngle -= FOURTH_QUADRANT; }
				
				if (wheelSpeed <= 0) {
					// TESTING: FORCE THE OUTCOME
					wheelAngle = FIRST_QUADRANT-10;
					/***********************************************/
					wheelPhase = WheelSpinPhase.SPIN_COMPLETE;
				}
				break;
				
			case WheelSpinPhase.SPIN_COMPLETE:
				if (objInputManager.pressed.space) {
					
					if (wheelAngle >= THIRD_QUADRANT && wheelAngle < FOURTH_QUADRANT) {
						global.playerHp = global.playerMaxHp;
					} else if (wheelAngle >= SECOND_QUADRANT && wheelAngle < THIRD_QUADRANT) {
						global.playerMaxHp++;
						global.playerHp = global.playerMaxHp;
						
					} else if (wheelAngle >= FIRST_QUADRANT && wheelAngle < SECOND_QUADRANT) {
						// Increased Dash Distance
					} else {
						global.playerSpeed++;
					}
					
					global.gamePaused = false;
					
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
					
				}
				break;
		}
	}
}




function GameStatePlayerDeath() {
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
				
				if (wheelAngle >= FOURTH_QUADRANT) wheelAngle -= FOURTH_QUADRANT;
				
				if (wheelSpeed <= 0) {
					wheelPhase = WheelSpinPhase.SPIN_COMPLETE;
				}
				break;
				
			case WheelSpinPhase.SPIN_COMPLETE:
				if (objInputManager.pressed.space) {
					if (wheelAngle >= 0 && wheelAngle < SECOND_QUADRANT) {
						global.gamePaused = false;
						
						with (objPlayer) {
							global.playerHp = global.playerMaxHp;
							playerState = playerStatePrev;
							sprite_index = sprPlayer;
							image_blend = c_white;
							image_speed = 1;
						}
						
						with (objEnemyParent) {
							enemyState = enemyStatePrev;
							image_speed = 1;
						}
						
						global.gameState = GameStateDefault;
						
					} else { // TODO: Game Over... go back to main menu when the player presses SPACE
						global.gamePaused = false;
						GameLose();
					}
				}
				break;
		}
	}
}
