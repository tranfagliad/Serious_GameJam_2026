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

	isSpinning = (spinSpeed > 0);
	if (isSpinning) {
		image_angle += spinSpeed;
        
        // Only pick up items if spinning fast enough
        if (spinSpeed >= tornadoThreshold) {
		    PlayerTornadoItemPickup(PLAYER_WIDTH);
        }
	} else {
        // If the spin completely dies out, clear the inventory contents
        global.inventory.papers = 0;
        global.inventory.computers = 0;
        global.inventory.staples = 0;
        total_items = 0;
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
	
	// Enemy collision logic...
	var _enCol = instance_place(x, y, objEnemyParent);
	if instance_exists(_enCol) && invulCd <= 0 {
		
		if _enCol.damageActive {
			var _dmg = _enCol.damage;
			currentHp -= _dmg;
			if currentHp <= 0 GameLose();
			
			invulCd = invulCdMax;
			image_blend = c_red;
		}
		
		with _enCol {
			hp -= other.playerDamage;
			if hp <= 0 {
				damageActive = false;
				explodeCd = 90;
				enemyState = EnemyStateExplode;
				sprite_index = sprPlaceholderExplosion;
			}
		}
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
