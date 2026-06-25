
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
	
	draw_set_halign(fa_right);
	draw_text(VIEWPORT_WIDTH - 16,	96+15*1,	$"enemy spawn cd: {global.enemySpawnCd}");
	draw_text(VIEWPORT_WIDTH - 16,	96+15*2,	$"enemy defeated: {global.enemyDefeated}");
	draw_text(VIEWPORT_WIDTH - 16,	96+15*3,	$"enemy defeated req: {global.enemyDefeatedReq}");
	draw_set_halign(fa_left);
	
	//reset
	draw_set_color(c_white);
	
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
	
}


if (global.gameState == GameStateLevelComplete) {
	
	draw_set_alpha(0.7);
	draw_rectangle_colour(0, 0, VIEWPORT_WIDTH, VIEWPORT_HEIGHT, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1.0);
	
	var _cx = VIEWPORT_WIDTH / 2;
	var _cy = VIEWPORT_HEIGHT / 2 - 20;
	
	draw_sprite_ext(sprUpgradeWheel, 0, _cx, _cy, 1.0, 1.0, wheelAngle, c_white, 1.0);
	draw_sprite(sprWheelPointer, 0, _cx, _cy - 200);
	
	draw_set_font(fntConsolBig);
	draw_set_valign(fa_top);
	draw_set_halign(fa_center);
	
	var _text_y = _cy + 276;
	var _inst_text = "";
	var _text_color = c_yellow;
	
	switch (wheelPhase) {
		case WheelSpinPhase.WAITING:
			_inst_text = "PRESS [SPACE] TO SPIN THE UPGRADE WHEEL!";
			_text_color = c_yellow;
			break;
		case WheelSpinPhase.SPINNING:
			_inst_text = "SPINNING...";
			_text_color = c_orange;
			break;
		case WheelSpinPhase.SPIN_COMPLETE:
			if (wheelAngle >= THIRD_QUADRANT && wheelAngle < FOURTH_QUADRANT) {
				_inst_text = "Health Restored!";
				// Powerup
			} else if (wheelAngle >= SECOND_QUADRANT && wheelAngle < THIRD_QUADRANT) {
				_inst_text = "Additional Health Slot!";
				// Powerup
			} else if (wheelAngle >= FIRST_QUADRANT && wheelAngle < SECOND_QUADRANT) {
				_inst_text = "Increased Dash Distance!";
				
				// Powerup
			} else {
				_inst_text = "Increased Movement Speed!"
				// Powerup
			}
		
			_inst_text += " Press [SPACE] to proceed.";
			_text_color = c_lime;
			break;
	}
	
	// Draw dropping shadow text behind main text loop
	draw_text_colour(_cx + 2, _text_y + 22, _inst_text, c_black, c_black, c_black, c_black, 1.0);
	draw_text_colour(_cx, _text_y+20, _inst_text, _text_color, _text_color, _text_color, _text_color, 1.0);
}