
draw_self();

//setup font and alignment
draw_set_font(fntConsol);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//debug ui
if global.showDebugUI {
	
	draw_text(x,	y+15*0,	$"spinning: {isSpinning}");
	
}

if (isSpinning) {
    draw_sprite_ext(sprPlaceholderTornado, image_index, x, y, 1, 1, image_angle, c_white, 1);
}



