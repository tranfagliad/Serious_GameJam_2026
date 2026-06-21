
//setup font and alignment
draw_set_font(fntConsol);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//debug ui
if global.showDebugUI {
	
	draw_text(10,	15*1,	$"FPS: {fps}");
	draw_text(10,	15*2,	$"FPS REAL: {fps_real}");
	
}


draw_text(10, 15*4, "Papers:    " + string(global.inventory.papers));
draw_text(10, 15*5, "Computers: " + string(global.inventory.computers));
draw_text(10, 15*6, "Staples:   " + string(global.inventory.staples));



