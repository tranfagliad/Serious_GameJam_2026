if !global.gamePaused && !global.midTransition {
	
	//cd until dissapearing
	trapCd = Approach(trapCd, 0, 1);
	if trapCd <= 0 instance_destroy();
	
}