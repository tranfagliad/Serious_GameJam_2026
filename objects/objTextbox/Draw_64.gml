draw_self();
//draw_sprite_ext(sprTextbox, 0, x,y, image_xscale, image_yscale, 0, c_white, image_alpha);

if textboxState == TextboxStateDialogue {
	
	//text params
	draw_set_font(fntConsolBig);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	//potential scaling
	var _scale = 1;
	
	//get text parameters
	var _print = string_copy(textMessage,1,textProgress);
	var _x = floor(x + textX);
	var _y = floor(y + textY);
	var _c = textCol;
	var _a = textAlpha;
	var _w = textW;
	
	//draw the text
	draw_text_ext_transformed_color(_x,_y, _print, -1, _w, _scale,_scale, 0, _c,_c,_c,_c, _a);
	
	
	//draw message over arrow
	if textProgress >= textLength {
		
		//setup arrow position
		var _xx = bbox_right - 24;
		var _yy = bbox_bottom - 24;
		
		//draw and arrow
		draw_sprite_ext(sprArrow, 0, _xx, _yy, _scale, _scale, 0,c_white, image_alpha);
		
	}

}