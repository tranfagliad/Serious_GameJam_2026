
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
	
	// Standardize fonts and center points
	draw_set_font(fntConsol);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	var _x = VIEWPORT_WIDTH / 2;
	var _y = VIEWPORT_HEIGHT / 2;
	
	// 1. Draw a translucent horizontal cinematic backdrop band
	draw_set_alpha(0.65);
	draw_rectangle_colour(0, _y - 45, VIEWPORT_WIDTH, _y + 45, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1.0); // Reset alpha
	
	// 2. Draw Drop Shadow Text
	draw_text_transformed_colour(_x + 2, _y + 2, "LEVEL COMPLETE", 2.5, 2.5, 0, c_black, c_black, c_black, c_black, 1);
	
	// 3. Draw Main Core Heading Text
	draw_text_transformed_colour(_x, _y, "LEVEL COMPLETE", 2.5, 2.5, 0, c_lime, c_lime, c_lime, c_lime, 1);
}

