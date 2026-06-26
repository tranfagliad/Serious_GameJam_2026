if !global.gamePaused && !global.midTransition {
	
	//state machine
	enemyState();
	
	//invul cd is separate
	invulCd = Approach(invulCd, 0, 1);
	if (invulCd <= 0) && (image_blend == global.enemyHitColor) image_blend = c_white;
	
}