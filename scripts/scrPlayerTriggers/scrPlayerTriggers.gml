function PlayerHit(_damage){
	
	//hp reduction
	currentHp -= _damage;
	if currentHp <= 0 GameLose();
	
	//invulnerability
	invulCd = invulCdMax;
	image_blend = c_red;
	
	//screen shake
	ScreenShakeStart(60, 6);
	
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