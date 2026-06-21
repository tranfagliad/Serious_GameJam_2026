
function draw_player_health (_current_hp, _max_hp) {
	
	for (var _i = 0; _i < _max_hp; _i++) {
		var _frame = (_i < _current_hp) ? 0 : 1;
		var _draw_x = (VIEWPORT_WIDTH - 200) + (_i * 40);
		
		draw_sprite_ext(sprPlaceholderPlayerHealth, _frame, _draw_x, 20, 2, 2, 0, c_white, 1);
	}
}


