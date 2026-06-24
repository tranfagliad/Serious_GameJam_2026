if !global.gamePaused && !global.midTransition {
	
	//cooldown until expiring
	explodeCd = Approach(explodeCd, 0, 1);
	if explodeCd <= 0 instance_destroy();
	
}