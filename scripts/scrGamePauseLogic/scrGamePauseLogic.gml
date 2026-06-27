function PauseMenuCreate(){
	
	//set starting vertical position
	var _startY = 96;	
		
	//upper buttons scale
	var _xscale = 4;
	var _yscale = 1;
	var _shiftX = 128;
		
	//ambient office
	var _x = _shiftX;
	var _y = _startY;
	instance_create_layer(_x,_y, "System", objButtonPause, {butScript: PauseUpdateAmbientOffice, image_xscale: _xscale, image_yscale: _yscale});
		
	//ambient tornado
	var _x = _shiftX + sprite_get_width(sprButtonBorder)*_xscale + 64;
	var _y = _startY;
	instance_create_layer(_x,_y, "System", objButtonPause, {butScript: PauseUpdateAmbientTornado, image_xscale: _xscale, image_yscale: _yscale});
		
	//sfx voume
	for (var i = 0; i <= 10; i++){
			
		var _xscale = 0.4;
		var _yscale = 0.5;
		var _shiftX = 80;
		var _shiftY = 64;
			
		var _x = _shiftX + sprite_get_width(sprButtonBorder)*_xscale * i;
		var _y = _startY + _shiftY;
		//instance_create_layer(_x, _y, "System", objButtonVolume, {butScript: PauseUpdateVolumeSound, image_xscale: _xscale, image_yscale: _yscale, butVolume: 0.1*i});
			
	}
		
	//music voume
	for (var i = 0; i <= 10; i++){
			
		var _xscale = 0.4;
		var _yscale = 0.5;
		var _shiftX = 80;
		var _shiftY = (64+32);
			
		var _x = _shiftX + sprite_get_width(sprButtonBorder)*_xscale * i;
		var _y = _startY + _shiftY;
		//instance_create_layer(_x, _y, "System", objButtonVolume, {butScript: PauseUpdateVolumeMusic, image_xscale: _xscale, image_yscale: _yscale, butVolume: 0.1*i});
			
	}
		
		
	//bottom buttons scale
	var _xscale = 1;
	var _yscale = 1;
	var _shiftX = 128;
	var _shiftY = (64+32+48);
		
	//dialogue sfx
	var _x = _shiftX;
	var _y = _startY + _shiftY;
	instance_create_layer(_x,_y, "System", objButtonPause, {butScript: PauseUpdateSfxText, image_xscale: _xscale, image_yscale: _yscale});
		
	//screen shake
	var _x = _shiftX + sprite_get_width(sprButtonBorder)*_xscale + 64;
	var _y = _startY + _shiftY;
	instance_create_layer(_x,_y, "System", objButtonPause, {butScript: PauseUpdateScreenShake, image_xscale: _xscale, image_yscale: _yscale});
	
}

function PauseActivate(){
	
	//pause all animation
	with all {
		
		gamePausedImageSpeed = image_speed;
		image_speed = 0;
		
	}
	
	//pause all sounds
	audio_pause_all();
	
	//make pause menu
	PauseMenuCreate();
	
	
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
	
	//check office ambient YEAH I KNOW OPTIMIZING IS FOR LOSERS BRO
	if global.ambientOfficeActive && (room == rmLevelOne || room == rmLevelTwo || room == rmLevelThree || room == rmBossLevel) {
		AmbientChange(AMBIENT_OFFICE, bgmAmbientOffice, 15);
	}
	
	
	//destroy pause menu
	with objButtonPause instance_destroy();
	
	//set flag
	global.gamePaused = false;
	
	//reset state
	global.gameState = global.gameStatePrev;
	
}