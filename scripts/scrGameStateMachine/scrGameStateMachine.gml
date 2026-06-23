function GameStateDefault(){
	
	//countdown enemy spawn cooldown
	global.enemySpawnCd = Approach(global.enemySpawnCd, 0, 1);
	if global.enemySpawnCd <= 0 {
		
		//refresh cd
		global.enemySpawnCd = global.enemySpawnCdMax;
		
		//choose an enemy (can introduce weighted randomness later maybe)
		var _enemyType = choose(objEnemyDefault, objEnemyDefault);
		
		// choose the random sprite
		var _spr = choose(sprEnemy1M, sprEnemy1F, sprEnemy2M);
		
		// Get enemy size based on the chosen sprite
		var _w = sprite_get_width(_spr);
		var _h = sprite_get_height(_spr);
		
		//choose a random position within room
		var _x = irandom_range(_w, room_width - _w);
		var _y = irandom_range(_h, room_height - _h);
		
		// capture the instance ID when creating it
		var _inst = instance_create_layer(_x, _y, "Enemy", _enemyType);
		
		// assign the chosen sprite
		if (instance_exists(_inst)) {
			_inst.sprite_index = _spr;
		}
	}
}

function GameStatePaused(){
	
	
	
}

function GameStateDialogue(){
	
	//check if textbox is removed
	if !instance_exists(objTextbox) {
		DialogueClean();
		global.gameState = global.gameStateTarget;
	}
	
}