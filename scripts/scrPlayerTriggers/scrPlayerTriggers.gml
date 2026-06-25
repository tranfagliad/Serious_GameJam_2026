function PlayerHit(_damage){
	
	// hp reduction
	currentHp -= _damage;
	
	// Player Death
	if (currentHp <= 0) {
		PlayerDeath();
	}
	
	//invulnerability
	invulCd = invulCdMax;
	image_blend = c_red;
	
	//screen shake
	ScreenShakeStart(60, 6);
}



function PlayerDeath () {

	currentHp = 0;   // Prevent HP from becoming negative
		
	with (objGameController) {
		wheelPhase = 0;
		wheelAngle = irandom(359);
		wheelSpeed = 0;
	}
	with (objPlayer) {
		playerStatePrev = playerState;
		image_speed = 0;
	}
	with (objEnemyParent) {
		enemyStatePrev = enemyState;
		image_speed = 0;
	}
		
	// Empty Inventory on death (?)
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
		
	global.gameState = GameStatePlayerDeath;
}




function PlayerStatsSaveUp(){
	with objPlayer {
		
		//save hp between transitions
		global.playerHp = currentHp;
		
		//whatever else is needed
		
	}
}




function PlayerStatsLoadUp(){
	with objPlayer {
		
		//load hp between transitions
		currentHp = global.playerHp;
		
		//whatever else is needed
		
	}
}