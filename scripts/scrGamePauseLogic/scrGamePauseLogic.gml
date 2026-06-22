function PauseActivate(){
	
	//pause all animation
	with all {
		
		gamePausedImageSpeed = image_speed;
		image_speed = 0;
		
	}
	// Test comment
	//pause all sounds
	audio_pause_all();
	
	//lock game state
	global.gameStatePrev = global.gameState;
	global.gameState = GameStatePaused;
	
	//set flag
	global.gamePaused = true;
	
}

function PauseDeactivate(){
	
	//resume all animation
	with all {
		if variable_instance_exists(id,"gamePausedImageSpeed")	image_speed = gamePausedImageSpeed;
	}
	
	//resume all sounds
	audio_resume_all();
	
	
	//set flag
	global.gamePaused = false;
	
	//reset state
	global.gameState = global.gameStatePrev;
	
}