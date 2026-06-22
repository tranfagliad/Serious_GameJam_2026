
//setup font and alignment
draw_set_font(fntConsol);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//debug ui
if global.showDebugUI {
	
	draw_set_halign(fa_left);
	draw_text(10,	15*1,	$"FPS: {fps}");
	draw_text(10,	15*2,	$"FPS REAL: {fps_real}");
	
	draw_set_halign(fa_right);
	draw_text(VIEWPORT_WIDTH - 16,	15*1,	$"enemy spawn cd: {global.enemySpawnCd}");
	draw_set_halign(fa_left);
	
}

//inventory
draw_text(10, 15*4, "Papers:    " + string(global.inventory.papers));
draw_text(10, 15*5, "Computers: " + string(global.inventory.computers));
draw_text(10, 15*6, "Staplers:   " + string(global.inventory.staplers));

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
