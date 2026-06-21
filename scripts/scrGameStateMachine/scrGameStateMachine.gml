function GameStateDefault(){
	
	//countdown enemy spawn cooldown
	global.enemySpawnCd = Approach(global.enemySpawnCd, 0, 1);
	if global.enemySpawnCd <= 0 {
		
		//refresh cd
		global.enemySpawnCd = global.enemySpawnCdMax;
		
		//choose an enemy (can introduce weighted randomness later maybe)
		var _enemyType = choose(objEnemyDefault, objEnemyDefault);
		
		//get enemy size
		var _spr = object_get_sprite(_enemyType) ?? sprPlaceholderEnemy;
		var _w = sprite_get_width(_spr);
		var _h = sprite_get_height(_spr);
		
		//choose a random position within room
		var _x = irandom_range(_w, room_width - _w);
		var _y = irandom_range(_h, room_height - _h);
		
		//spawn enemy on the enemy layer
		instance_create_layer(_x,_y, "Enemy", _enemyType);
		
	}
	
}

function GameStatePaused(){
	
	
	
}