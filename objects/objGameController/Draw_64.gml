
//setup font and alignment
draw_set_font(fntConsol);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//debug ui
if global.showDebugUI {
	
	//make it not white
	draw_set_colour(c_gray);
	
	//get zoom
	var _camZ = 1;
	with objCamera _camZ = zoomFactor;
	
	draw_set_halign(fa_left);
	draw_text(10,	96+15*1,	$"FPS: {fps}");
	draw_text(10,	96+15*2,	$"FPS REAL: {fps_real}");
	draw_text(10,	96+15*3,	$"Zoom Factor: {_camZ}");
	draw_text(10,	96+15*5,	$"Music Volume: {global.musicVolume}");
	draw_text(10,	96+15*6,	$"Sound Volume: {global.soundVolume}");
	
	draw_set_halign(fa_right);
	draw_text(VIEWPORT_WIDTH - 16,	96+15*1,	$"enemy spawn cd: {global.enemySpawnCd}");
	draw_text(VIEWPORT_WIDTH - 16,	96+15*2,	$"enemy defeated: {global.enemyDefeated}");
	draw_text(VIEWPORT_WIDTH - 16,	96+15*3,	$"enemy defeated req: {global.enemyDefeatedReqCurrent}");
	//draw_text(VIEWPORT_WIDTH - 16,	96+15*4,	$"boss track pos: {MusicChangeBoss()}");
	draw_set_halign(fa_left);
	
	//reset
	draw_set_color(c_white);
	
}

//draw reminder
if global.cheat {
	
	draw_set_colour(c_yellow);
	draw_set_halign(fa_left);
	draw_text(10,	VIEWPORT_HEIGHT - 80,	$"CHEATS ARE ACTIVE (YOU FOOLS)");
	
}

//draw pause
if global.gamePaused {
	
	//transparent cover
	draw_set_alpha(0.5);
	draw_rectangle_colour(0,0, VIEWPORT_WIDTH, VIEWPORT_HEIGHT, c_white,c_white,c_white,c_white, false);
	draw_set_alpha(1);
	
	//text
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	var _c1 = c_black;
	var _c2 = c_white;
	var _x = VIEWPORT_WIDTH/2;
	var _y = VIEWPORT_HEIGHT/2;
	draw_text_transformed_colour(_x + 1, _y + 1,	$"PAUSED", 3,3, 0, _c1,_c1,_c1,_c1, 1);
	draw_text_transformed_colour(_x, _y,			$"PAUSED", 3,3, 0, _c2,_c2,_c2,_c2, 1);
	
	
	//draw buttons
	with objButtonPause {
		
		draw_self();
		draw_set_font(fntConsolBig);
		draw_set_valign(fa_top);
		draw_set_halign(fa_left);
		
		//setup text
		var _text = butName;
		var _c = c_white; // #FBFF86;
		if image_index == 2 _c = c_gray;

		//setup position
		var _x = floor(bbox_left + (bbox_right - bbox_left)/2 - string_width(_text)/2);
		var _y = floor(bbox_top + (bbox_bottom - bbox_top)/2 - string_height(_text)/2);

		//draw text
		draw_text_transformed_color(_x,_y, _text, 1, 1, 0, _c,_c,_c,_c, image_alpha);
		
	}
	
}


if (global.gameState == GameStateLevelComplete) {
	SpinPowerUpWheel();
}

if (global.gameState == GameStatePlayerDeath) {
	SpinRevivalWheel();
}
