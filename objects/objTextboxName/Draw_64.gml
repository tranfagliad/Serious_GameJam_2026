draw_self();

//text params
draw_set_font(fntConsolBig);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

//possible scaling
var _scale = 1;
	
//get text parameters
var _print = textMessage;
var _x = x + textX;
var _y = y + textY;
var _c = textCol;
	
//draw the text
draw_text_transformed_color(_x,_y,_print, _scale,_scale,0, _c,_c,_c,_c, image_alpha);