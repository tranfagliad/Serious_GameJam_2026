if !global.gamePaused && !global.midTransition {

	if global.gameState == GameStateDefault {
	
		with objCamera followTarget = objPlayer;
		instance_destroy();
	
	} else {
	
		with objCamera {
			followTarget = other.id;
			zoomFactor = Approach(zoomFactor, 1, 0.01);
			zoomFactor = clamp(zoomFactor, zoomFactorMin, zoomFactorMax);
		}
	
	}

}