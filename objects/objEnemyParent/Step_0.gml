if !global.gamePaused && !global.midTransition {
	
	//state machine
	enemyState();
	
	//invul cd is separate
	invulCd = Approach(invulCd, 0, 1);
	
}