
function CheckPlayerCollisionMap (_move_x, _move_y) {
	var _collision = false;
	
	// WEB BUG PROTECTION: Bypasses checks if tilemap is broken to prevent browser lag
	if (collisionMap == -1 || !layer_tilemap_exists(layer_get_id("CollisionMap"), collisionMap)) {
		x += _move_x;
		y += _move_y;
		return false; 
	}
	
	var _half_w = floor(PLAYER_WIDTH_COLLISION / 2);
	var _half_h = floor(PLAYER_HEIGHT_COLLISION / 2);
	
	_move_x = round(_move_x);
	_move_y = round(_move_y);
	
	var _steps_x = ceil(abs(_move_x) / 4);
	var _steps_y = ceil(abs(_move_y) / 4);
	
	if (_steps_x == 0) _steps_x = 1;
	if (_steps_y == 0) _steps_y = 1;
	
	var _sub_move_x = _move_x / _steps_x;
	var _sub_move_y = _move_y / _steps_y;
	
	// --- X AXIS COLLISION ---
	repeat (_steps_x) {
		if (_sub_move_x != 0) {
			var _check_x = (_sub_move_x > 0) ? round(x + _half_w + _sub_move_x) : round(x - _half_w + _sub_move_x);
			
			var _side_y1 = round(y - _half_h);
			var _side_y2 = round(y + _half_h);
			var _hit_x = false;
			
			for (var _check_y = _side_y1; _check_y <= _side_y2; _check_y += 5) {
				var _y_to_test = min(_check_y, _side_y2); 
				
				if (tilemap_get_at_pixel(collisionMap, _check_x, _y_to_test)) {
					if (_sub_move_x > 0) {
						x = _check_x - (_check_x mod 5) - _half_w - 1;
					} else {
						x = _check_x - (_check_x mod 5) + 5 + _half_w;
					}
					x = round(x); 
					_sub_move_x = 0;
					_collision = true;
					_hit_x = true;
					break;
				}
			}
			if (_hit_x) break; 
			x += _sub_move_x;
		}
	}
	
	// --- Y AXIS COLLISION ---
	repeat (_steps_y) {
		if (_sub_move_y != 0) {
			var _check_y = (_sub_move_y > 0) ? round(y + _half_h + _sub_move_y) : round(y - _half_h + _sub_move_y);
			
			var _side_x1 = round(x - _half_w);
			var _side_x2 = round(x + _half_w);
			var _hit_y = false;
			
			for (var _check_x = _side_x1; _check_x <= _side_x2; _check_x += 5) {
				var _x_to_test = min(_check_x, _side_x2);
				
				if (tilemap_get_at_pixel(collisionMap, _x_to_test, _check_y)) {
					if (_sub_move_y > 0) {
						y = _check_y - (_check_y mod 5) - _half_h - 1;
					} else {
						y = _check_y - (_check_y mod 5) + 5 + _half_h;
					}
					y = round(y); 
					_sub_move_y = 0;
					_collision = true;
					_hit_y = true;
					break;
				}
			}
			if (_hit_y) break; 
			y += _sub_move_y;
		}
	}
	
	return _collision;
}






// Check for player collision with the given object, return booleans for x and y collisions
function CheckForPlayerCollision (_move_x, _move_y, _collision_object) {
	return {
		collidedX: place_meeting(x + _move_x, y, _collision_object),
		collidedY: place_meeting(x, y + _move_y, _collision_object)
	};
}
