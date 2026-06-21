function PlayerStateDefault(){
	
	// Detect Inputs
	var _input_x = objInputManager.held.right - objInputManager.held.left;
	var _input_y = objInputManager.held.down - objInputManager.held.up;


	// Spin
	isSpinning = objInputManager.held.space;
	if (isSpinning) {
		image_angle += spinSpeed;
		PlayerTornadoItemPickup(PLAYER_WIDTH);
	}
	// Reset orientation?
	/*else {
		image_angle = 0;
	}
	*/


	// Player Movement
	if (_input_x != 0 || _input_y != 0) {

	    var _direction = point_direction(0, 0, _input_x, _input_y);
    
	    var _move_x = lengthdir_x(playerSpeed, _direction);
	    var _move_y = lengthdir_y(playerSpeed, _direction);
	
		// Check for collisions with tables
		var _collision = CheckForPlayerCollision(_move_x, _move_y, objParentTable);
		x = _collision.collidedX ? x : x + _move_x;
		y = _collision.collidedY ? y : y + _move_y;
	}
	
	
	//enemy collision
	var _enCol = instance_place(x,y, objEnemyParent);
	if instance_exists(_enCol) && invulCd <= 0 {
		
		//check if enemy is actively damaging
		if _enCol.damageActive {
			
			//get enemy damage
			var _dmg = _enCol.damage;
		
			//reduce hp
			currentHp -= _dmg;
			if currentHp <= 0 GameLose();
			
			//refresh invul cooldown
			invulCd = invulCdMax;
			image_blend = c_red;
		
		}
		
		//deal damage to the enemy
		with _enCol {
			
			hp -= other.playerDamage;
			if hp <= 0 {
				
				//deactivate damaging ability
				damageActive = false;
				
				//this should be a dying animation state
				explodeCd = 90;
				enemyState = EnemyStateExplode;
				sprite_index = sprPlaceholderExplosion;
				
			}
			
		}
		
	}
	
	//invul cooldown
	invulCd = Approach(invulCd, 0, 1);
	if invulCd == 0 {
		image_blend = c_white;
		invulCd = -1;
	}
	

	// Do not leave the bounds of the level
	x = clamp(x, PLAYER_CENTER, room_width - PLAYER_CENTER);
	y = clamp(y, PLAYER_CENTER, room_height - PLAYER_CENTER);

	
}