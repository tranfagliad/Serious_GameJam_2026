
function DrawPlayerHealth () {
	
	draw_sprite_ext(sprHealthBadge, 0, VIEWPORT_WIDTH-10, 10, 2, 2, 0, c_white, 1);
	
	for (var _i = 0; _i < global.playerMaxHp; _i++) {
		var _frame = (_i < global.playerHp) ? 0 : 1;
		var _right_anchor = VIEWPORT_WIDTH - 170; 
		var _draw_x = _right_anchor - (_i * 45);
		
		draw_sprite_ext(sprHealthBadgeChunk, 0, _draw_x, 10, 2, 2, 0, c_white, 1);
		draw_sprite_ext(sprPlayerHealth, _frame, _draw_x, 53, 2, 2, 0, c_white, 1);
	}
	
	var _tail_anchor = VIEWPORT_WIDTH - 147;
	var _tail_x = _tail_anchor - (global.playerMaxHp * 45);
	draw_sprite_ext(sprHealthBadgeTail, 0, _tail_x, 10, 2, 2, 0, c_white, 1);
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


function DrawPlayerSpinMeter (_spin_speed, _max_spin_speed, _dashCd, _dashCdMax) {
	
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
	
	//setup sprite position and scale
	var _x = 20, _y = VIEWPORT_HEIGHT-10, _scale = 2;
	//setup dash percentage position
	var _x1 = _x + 150*_scale;
	var _x2 = _x + 205*_scale;
	var _y1 = _y - 46*_scale;
	var _y2 = _y - 13*_scale;
	
	var _percent = (1 - _dashCd/_dashCdMax)*100;
	var _col = #7CC237;
	draw_healthbar(_x1,_y1,_x2,_y2, _percent, c_white, _col, _col, 3, true, false);
	
	draw_sprite_ext(sprSpinMeter, _frame, 20, VIEWPORT_HEIGHT-10, 2, 2, 0, c_white, 1);
}


function DrawEnemyDefeatReq(_current, _req){
	
	if (_req <= 0) return;
	var _ratio = clamp(_current / _req, 0.0, 1.0);
	

	var _frame = floor((_ratio * 100) / 5);
	
	var _draw_x = VIEWPORT_WIDTH - 16;
	var _draw_y = VIEWPORT_HEIGHT - 16;
	
	draw_sprite_ext(sprEnemyReqMeter, _frame, _draw_x, _draw_y, 1.5, 1.5, 0, c_white, 1.0);
}