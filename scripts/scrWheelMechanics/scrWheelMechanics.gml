
function SpinPowerUpWheel () {

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
			_inst_text = "Press [SPACE] to Spin the Upgrade Wheel!";
			_text_color = c_yellow;
			break;
		case WheelSpinPhase.SPINNING:
			_inst_text = "";
			break;
		case WheelSpinPhase.SPIN_COMPLETE:
			if (wheelAngle >= THIRD_QUADRANT && wheelAngle < FOURTH_QUADRANT) {
				_inst_text = "Health Restored!";
				_text_color = c_orange;
			} else if (wheelAngle >= SECOND_QUADRANT && wheelAngle < THIRD_QUADRANT) {
				_inst_text = "Additional Health Slot!";
				_text_color = c_blue;
			} else if (wheelAngle >= FIRST_QUADRANT && wheelAngle < SECOND_QUADRANT) {
				_inst_text = "Increased Dash Distance!";
				_text_color = c_green;
			} else {
				_inst_text = "Increased Movement Speed!"
				_text_color = c_red;
			}
			_inst_text += " Press [SPACE] to proceed.";
			break;
	}
	
	// Draw dropping shadow text behind main text loop
	draw_text_colour(_cx + 2, _text_y + 22, _inst_text, c_black, c_black, c_black, c_black, 1.0);
	draw_text_colour(_cx, _text_y+20, _inst_text, _text_color, _text_color, _text_color, _text_color, 1.0);
}






function SpinRevivalWheel () {
	
	draw_set_alpha(0.75);
	draw_rectangle_colour(0, 0, VIEWPORT_WIDTH, VIEWPORT_HEIGHT, c_maroon, c_black, c_maroon, c_black, false);
	draw_set_alpha(1.0);
	
	var _cx = VIEWPORT_WIDTH / 2;
	var _cy = VIEWPORT_HEIGHT / 2 - 20;
	
	draw_sprite_ext(sprRevivalWheel, 0, _cx, _cy, 1.0, 1.0, wheelAngle, c_white, 1.0);
	draw_sprite(sprWheelPointer, 0, _cx, _cy - 200);
	
	draw_set_font(fntConsolBig);
	draw_set_valign(fa_top);
	draw_set_halign(fa_center);
	
	var _text_y = _cy + 276;
	var _inst_text = "";
	var _text_color = c_white;
	
	switch (wheelPhase) {
		case WheelSpinPhase.WAITING:
			_inst_text = "HP DEPLETED! PRESS [SPACE] TO SPIN FOR A CHANCE TO REVIVE!";
			_text_color = c_yellow;
			break;
			
		case WheelSpinPhase.SPINNING:
			_inst_text = "";
			_text_color = c_orange;
			break;
			
		case WheelSpinPhase.SPIN_COMPLETE:
			var _quadrant_text = "";
			if (wheelAngle >= SECOND_QUADRANT && wheelAngle < FOURTH_QUADRANT) {
				_quadrant_text = "Game Over...";
			} else {
				_quadrant_text = "Revived!";
			}
			
			_inst_text = _quadrant_text + " Press [SPACE] to proceed.";
			_text_color = c_red;
			break;
	}
	
	// Draw drop shadow and main instruction text
	draw_text_colour(_cx + 2, _text_y + 22, _inst_text, c_black, c_black, c_black, c_black, 1.0);
	draw_text_colour(_cx, _text_y+20, _inst_text, _text_color, _text_color, _text_color, _text_color, 1.0);
}
