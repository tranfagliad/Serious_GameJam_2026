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
	if (spinSpeed >= maxSpinSpeed && objInputManager.pressed.space && _is_moving && dashCd <= 0) {
		dashDirection = point_direction(0, 0, _input_x, _input_y);
		dashTimer = dashDuration*dashPower;
		playerState = PlayerStateDash;
		dashCd = dashCdMax;
		return;
	}
	
	//dash cd
	dashCd = Approach(dashCd, 0, 1);
	
	// Spin Animation
	isSpinning = (spinSpeed > 0);
	if (isSpinning) {
		image_speed = (spinSpeed / maxSpinSpeed) * 6;
	} else {
		image_speed = 0;
	}
	
	// Tornado
	if (spinSpeed >= tornadoThreshold) {
		PlayerTornadoItemPickup(PLAYER_WIDTH + 32);
		
		//enemy collision (replaced with separate object collision)
		//tornadoColCd = Approach(tornadoColCd, 0, 1);
		//if (tornadoColCd <= 0) PlayerTornadoEnemyCollision(PLAYER_WIDTH);
		
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
			
			// check if some items were removed
			while (array_length(_visual_array) > _target_count) {
				array_pop(_visual_array);
			}
			
			// Update the physics/rotation for everything in this specific category
			for (var _j = 0; _j < array_length(_visual_array); _j++) {
				var _item = _visual_array[_j];
				_item.orbit_angle += _item.orbit_speed + (spinSpeed * 0.1);
				_item.item_rotation += _item.item_spin_speed;
			}
			
			//update the struct with new array
			struct_set(global.inventoryVisuals, _category, _visual_array);
			
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
		
		//destroy all item objects
		with objItemParent instance_destroy();
	}


	// Player Movement
	if (_is_moving) {
		var _direction = point_direction(0, 0, _input_x, _input_y);
    
		var _move_x = lengthdir_x(playerSpeed, _direction);
		var _move_y = lengthdir_y(playerSpeed, _direction);
		
		CheckPlayerCollisionMap(_move_x, _move_y);
		// Check for collisions with tables
		//var _collision = CheckForPlayerCollision(_move_x, _move_y, objParentTable);
		//x = _collision.collidedX ? x : x + _move_x;
		//y = _collision.collidedY ? y : y + _move_y;
	}
	
	
	// Enemy collision logic
	PlayerCollisionEnemy();
	
	//trap collision logic
	var _trapCol = instance_place(x, y, objEnemyTrapTile);
	if instance_exists(_trapCol) && invulCd <= 0 {
		
		//slow spin (DEBATABLE MECHANIC)
		spinSpeed = Approach(spinSpeed, 0, spinDecel);
		
		//slow movement
		playerSpeed = playerSpeedSlowed;
		
	} else {
		
		//return normal speed
		playerSpeed = playerSpeedDefault;
		
	}
	
	
	// Invul cooldown
	invulCd = Approach(invulCd, 0, 1);
	if invulCd <= 0 image_blend = c_white;


	// Do not leave the bounds of the level
	clampBounds();
}


function PlayerStateDash () {
	
	spinSpeed = maxSpinSpeed;
	var _move_x = lengthdir_x(dashSpeed, dashDirection);
	var _move_y = lengthdir_y(dashSpeed, dashDirection);
	
	CheckPlayerCollisionMap(_move_x, _move_y);
	//var _collision = CheckForPlayerCollision(_move_x, _move_y, objParentTable);
	//x = _collision.collidedX ? x : x + _move_x;
	//y = _collision.collidedY ? y : y + _move_y;
	
	// Clamp to room bounds
	clampBounds();
	
	//regular enemy collision
	//PlayerCollisionEnemy();
	
	// Attack enemies with paper
	var _paperAmount = global.inventory.papers;
	if (_paperAmount > 0) {
		
		//larger collision range
		var _enCol = collision_circle(x,y, PLAYER_WIDTH, objEnemyParent, false, true);
		with _enCol if (damageActive && invulCd <= 0) {
			EnemyHit(other.playerDamage);
			
			//reduce paper amount
			_paperAmount = Approach(_paperAmount, 0, global.paperReductionAmount);
			global.inventory.papers = _paperAmount;
		}
		
	}
	
	dashTimer--;
	if (dashTimer <= 0) {
		
		//create an explosion (too much power?)
		//instance_create_layer(x,y, "Player", objDashExplosion);
		
		//check if any computers obtained
		if global.inventory.computers > 0 {
			
			//remove one computer from inventory
			global.inventory.computers -= 1;
			
			//make computer fly
			with objItemComputer {
				
				//move to the player position
				x = other.x;
				y = other.y;
				
				//setup dash
				dashDirection = other.dashDirection;
				dashSpeed = other.dashSpeed/2;
				itemState = ItemStateDash;
				
				//only one computer flies
				break;
				
			}
			
		}
		
		//stop dashing
		playerState = PlayerStateDefault;
		
		//make player invulnerable for a very short period after dash
		invulCd = 8;
		
	}
}


function PlayerStateLocked(){
	
}

function clampBounds () {
	x = clamp(x, PLAYER_CENTER-5, room_width - PLAYER_CENTER+5);
	y = clamp(y, PLAYER_CENTER-40, room_height - PLAYER_CENTER);
}
