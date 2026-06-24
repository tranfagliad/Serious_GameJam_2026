function GameStateDefault(){
	
	//countdown enemy spawn cooldown
	global.enemySpawnCd = Approach(global.enemySpawnCd, 0, 1);
	if global.enemySpawnCd <= 0 {
		
		//refresh cd
		global.enemySpawnCd = global.enemySpawnCdMax;
		
		//choose an enemy (can introduce weighted randomness later maybe)
		var _enemyType = choose(objEnemyDefault, objEnemyDash, objEnemyTrap);

		// Get enemy size (based on first sprite)
		var _w = sprite_get_width(sprEnemy1F);
		var _h = sprite_get_height(sprEnemy1F);
		
		//choose a random position within room
		var _x = irandom_range(_w, room_width - _w);
		var _y = irandom_range(_h, room_height - _h);
		
		//just create the enemy
		instance_create_layer(_x, _y, "Enemy", _enemyType);
		
	}
	
	
	//level complete
	if global.enemyDefeated >= global.enemyDefeatedReq {
		
		global.enemyDefeated = 0;
		switch room {
			
			case rmLevelOne: {
				
				//transition to next room
				room_goto(rmLevelOne);
				
			} break;
			
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