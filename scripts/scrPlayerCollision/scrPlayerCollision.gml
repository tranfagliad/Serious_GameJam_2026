
// A little hacky, but it works
function CheckPlayerCollisionMap (_move_x, _move_y) {
	var _collision = false;
	
	var _half_w = PLAYER_WIDTH_COLLISION / 2;
	var _half_h = PLAYER_HEIGHT_COLLISION / 2;
	
	// Determine how many sub-steps we need based on how fast we are going.
	// If dashSpeed is 12 and TILESIZE is 5, we divide by 5 and round up to do 3 mini-steps.
	var _steps_x = ceil(abs(_move_x) / COLLISION_TILESIZE);
	var _steps_y = ceil(abs(_move_y) / COLLISION_TILESIZE);
	
	// If we are stationary, ensure at least 1 loop run to check standing state
	if (_steps_x == 0) _steps_x = 1;
	if (_steps_y == 0) _steps_y = 1;
	
	// Break the total movement down into safe sub-pixel increments
	var _sub_move_x = _move_x / _steps_x;
	var _sub_move_y = _move_y / _steps_y;
	
	// --- X AXIS COLLISION (Sub-stepped) ---
	repeat (_steps_x) {
		if (_sub_move_x != 0) {
			var _check_x = (_sub_move_x > 0) ? (x + _half_w + _sub_move_x) : (x - _half_w + _sub_move_x);
			
			var _side_y1 = y - _half_h;
			var _side_y2 = y + _half_h;
			var _hit_x = false;
			
			for (var _check_y = _side_y1; _check_y <= _side_y2; _check_y += COLLISION_TILESIZE) {
				var _y_to_test = min(_check_y, _side_y2); 
				
				if (tilemap_get_at_pixel(collisionMap, _check_x, _y_to_test)) {
					if (_sub_move_x > 0) {
						x = _check_x - (_check_x mod COLLISION_TILESIZE) - _half_w - 1;
					} else {
						x = _check_x - (_check_x mod COLLISION_TILESIZE) + COLLISION_TILESIZE + _half_w;
					}
					_sub_move_x = 0;
					_collision = true;
					_hit_x = true;
					break;
				}
			}
			if (_hit_x) break; // Terminate further steps along X
			x += _sub_move_x;
		}
	}
	
	// --- Y AXIS COLLISION (Sub-stepped) ---
	repeat (_steps_y) {
		if (_sub_move_y != 0) {
			var _check_y = (_sub_move_y > 0) ? (y + _half_h + _sub_move_y) : (y - _half_h + _sub_move_y);
			
			var _side_x1 = x - _half_w;
			var _side_x2 = x + _half_w;
			var _hit_y = false;
			
			for (var _check_x = _side_x1; _check_x <= _side_x2; _check_x += COLLISION_TILESIZE) {
				var _x_to_test = min(_check_x, _side_x2);
				
				if (tilemap_get_at_pixel(collisionMap, _x_to_test, _check_y)) {
					if (_sub_move_y > 0) {
						y = _check_y - (_check_y mod COLLISION_TILESIZE) - _half_h - 1;
					} else {
						y = _check_y - (_check_y mod COLLISION_TILESIZE) + COLLISION_TILESIZE + _half_h;
					}
					_sub_move_y = 0;
					_collision = true;
					_hit_y = true;
					break;
				}
			}
			if (_hit_y) break; // Terminate further steps along Y
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