
function DrawPlayerHealth (_current_hp, _max_hp) {
	
	for (var _i = 0; _i < _max_hp; _i++) {
		var _frame = (_i < _current_hp) ? 0 : 1;
		var _draw_x = (VIEWPORT_WIDTH - 200) + (_i * 40);
		
		draw_sprite_ext(sprPlaceholderPlayerHealth, _frame, _draw_x, 20, 2, 2, 0, c_white, 1);
	}
}



function DrawPlayerSpinMeter (_spin_speed, _max_spin_speed) {

	var _bar_width = 20;
	var _bar_height = 200;
	
	var _bar_x = VIEWPORT_WIDTH - 50;
	
	var _x1 = _bar_x - _bar_width;
	var _x2 = _bar_x;
	var _y1 = (VIEWPORT_HEIGHT / 2) - (_bar_height / 2);
	var _y2 = _y1 + _bar_height;
	
	// HTML5 Compatibility
	var _bg_color   = $222222;
	var _fill_color = $00CC00;
	
	draw_rectangle_color(_x1, _y1, _x2, _y2, _bg_color, _bg_color, _bg_color, _bg_color, false);
	
	var _percentage = (_spin_speed / _max_spin_speed);
	var _fill_y1 = _y2 - (_bar_height * _percentage);
	
	if (_percentage > 0) {
		draw_rectangle_color(_x1, _fill_y1, _x2, _y2, _fill_color, _fill_color, _fill_color, _fill_color, false);
	}
	
	var _old_halign = draw_get_halign();
	var _old_valign = draw_get_valign();
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	
	var _text_x = _x1 + (_bar_width / 2);
	var _text_y = _y1 - 8;
	
	if (_percentage < 1.0) {
		draw_text(_text_x, _text_y, "Spin");
	} else {
		draw_text(_text_x, _text_y, "DASH!");
	}
	
	draw_set_halign(_old_halign);
	draw_set_valign(_old_valign);
	
	var _border_color = $FFFFFF;
	draw_rectangle_color(_x1, _y1, _x2, _y2, _border_color, _border_color, _border_color, _border_color, true);
}

