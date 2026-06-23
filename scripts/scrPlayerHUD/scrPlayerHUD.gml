
function DrawPlayerHealth (_current_hp, _max_hp) {
	
	draw_sprite_ext(sprHealthBadge, 0, VIEWPORT_WIDTH-10, 10, 2, 2, 0, c_white, 1);
	
	for (var _i = 0; _i < _max_hp; _i++) {
		var _missing_hp = _max_hp - _current_hp;
		var _frame = (_i >= _missing_hp) ? 0 : 1;
		
		var _draw_x = (VIEWPORT_WIDTH - 345) + (_i * 45);
		
		draw_sprite_ext(sprPlayerHealth, _frame, _draw_x, 53, 2, 2, 0, c_white, 1);
	}
}


function DrawInventory (_inventory) {
	
	draw_sprite_ext(sprStaplerBadge, 0, 20, 10, 2, 2, 0, c_white, 1);
	draw_sprite_ext(sprPaperBadge, 0, 200, 10, 2, 2, 0, c_white, 1);
	draw_sprite_ext(sprComputerBadge, 0, 380, 10, 2, 2, 0, c_white, 1);
	
	draw_set_halign(fa_right);
	draw_set_font(fntConsolHUD);
	draw_text(165, 20, string(_inventory.staplers));
	draw_text(345, 20, string(_inventory.papers));
	draw_text(525, 20, string(_inventory.computers));
	draw_set_halign(fa_left);
	draw_set_font(fntConsol);
}


function DrawPlayerSpinMeter (_spin_speed, _max_spin_speed, _dashCd) {
	
	var _percentage = (_spin_speed / _max_spin_speed);
	var _frame = 0;
	
	if (_percentage < 1.0) {
		// Maps 0.0 - 0.99 into explicit 20% chunks (Frames 0 to 4)
		// floor(0.15 * 5) = floor(0.75) = Frame 0
		// floor(0.85 * 5) = floor(4.25) = Frame 4
		_frame = floor(_percentage * 5);
		_frame = clamp(_frame, 0, 4); // Safety net clamp
	} else {
		// We are at 100% spin speed! Check if dash is ready or cooling down
		_frame = (_dashCd > 0) ? 6 : 5;
	}
	
	draw_sprite_ext(sprSpinMeter, _frame, 20, VIEWPORT_HEIGHT-10, 2, 2, 0, c_white, 1);
}
