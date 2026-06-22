function PlayerStateDefault(){
	
	// Detect Inputs
	var _input_x = objInputManager.held.right - objInputManager.held.left;
	var _input_y = objInputManager.held.down - objInputManager.held.up;
    
	// Check if the player is attempting to move
	var _is_moving = (_input_x != 0 || _input_y != 0);
	if (_is_moving) {
		spinSpeed = Approach(spinSpeed, maxSpinSpeed, spinAccel);
	} else {
		spinSpeed = Approach(spinSpeed, 0, spinDecel);
	}
	
	// Dash Mechanic
	if (spinSpeed >= maxSpinSpeed && objInputManager.pressed.space && _is_moving) {
		dashDirection = point_direction(0, 0, _input_x, _input_y);
		dashTimer = dashDuration;
		playerState = PlayerStateDash;
		return;
	}
	
	// Spin Animation
	isSpinning = (spinSpeed > 0);
	if (isSpinning) {
		image_angle += spinSpeed;
	}

	// Tornado
	if (spinSpeed >= tornadoThreshold) {
		PlayerTornadoItemPickup(PLAYER_WIDTH);
		
		//enemy collision
		tornadoColCd = Approach(tornadoColCd, 0, 1);
		if (tornadoColCd <= 0) PlayerTornadoEnemyCollision(PLAYER_WIDTH);
		
		// Get a list of all item categories in our inventory ("papers", "computers", etc.)
		var _categories = struct_get_names(global.inventory);
		
		for (var _i = 0; _i < array_length(_categories); _i++) {
			var _category = _categories[_i];
			
			// Get the target count from the inventory and our corresponding visual array
			var _target_count = struct_get(global.inventory, _category);
			var _visual_array = struct_get(global.inventoryVisuals, _category);
			
			// Catch up the visual array if new items were vacuumed
			while (array_length(_visual_array) < _target_count) {
				array_push(_visual_array, {
					orbit_angle: random(360),
					orbit_distance: random_range(16, PLAYER_WIDTH - 8),
					orbit_speed: random_range(4, 8),
					item_rotation: random(360),
					item_spin_speed: random_range(-5, 5)
				});
			}
			
			// Update the physics/rotation for everything in this specific category
			for (var _j = 0; _j < array_length(_visual_array); _j++) {
				var _item = _visual_array[_j];
				_item.orbit_angle += _item.orbit_speed + (spinSpeed * 0.1);
				_item.item_rotation += _item.item_spin_speed;
			}
		}
		
	} else {
		// If the tornado drops, wipe out data inventories
		global.inventory.papers = 0;
		global.inventory.computers = 0;
		global.inventory.staplers = 0;
		total_items = 0;
		
		// Reset all visual tracking arrays
		global.inventoryVisuals.papers = [];
		global.inventoryVisuals.computers = [];
		global.inventoryVisuals.staplers = [];
	}

	// Player Movement
	if (_is_moving) {
		var _direction = point_direction(0, 0, _input_x, _input_y);
    
		var _move_x = lengthdir_x(playerSpeed, _direction);
		var _move_y = lengthdir_y(playerSpeed, _direction);
	
		// Check for collisions with tables
		var _collision = CheckForPlayerCollision(_move_x, _move_y, objParentTable);
		x = _collision.collidedX ? x : x + _move_x;
		y = _collision.collidedY ? y : y + _move_y;
	}
	
	// Enemy collision logic
	var _enCol = instance_place(x, y, objEnemyParent);
	if instance_exists(_enCol) && invulCd <= 0 {
		
		//player takes a hit
		if _enCol.damageActive PlayerHit(_enCol.damage);
		
		//enemy also takes a hit
		with _enCol EnemyHit(other.playerDamage);
		
	}
	
	// Invul cooldown
	invulCd = Approach(invulCd, 0, 1);
	if invulCd == 0 {
		image_blend = c_white;
		invulCd = -1;
	}

	// Do not leave the bounds of the level
	x = clamp(x, PLAYER_CENTER, room_width - PLAYER_CENTER);
	y = clamp(y, PLAYER_CENTER, room_height - PLAYER_CENTER);
}




function PlayerStateDash () {

	spinSpeed = maxSpinSpeed;
	image_angle += spinSpeed;
	
	invulCd = invulCdMax;
	image_blend = c_aqua;
	
	var _move_x = lengthdir_x(dashSpeed, dashDirection);
	var _move_y = lengthdir_y(dashSpeed, dashDirection);
	
	var _collision = CheckForPlayerCollision(_move_x, _move_y, objParentTable);
	x = _collision.collidedX ? x : x + _move_x;
	y = _collision.collidedY ? y : y + _move_y;
	
	// Clamp to room bounds
	x = clamp(x, PLAYER_CENTER, room_width - PLAYER_CENTER);
	y = clamp(y, PLAYER_CENTER, room_height - PLAYER_CENTER);
	
	dashTimer--;
	if (dashTimer <= 0) {
		playerState = PlayerStateDefault;
		image_blend = c_white;
	}
}







