#region general scripts

	function EnemyMoveTo(_x,_y){
	
		//calculate movement towards position
		var _dir = point_direction(x,y, _x,_y);
		var _hsp = lengthdir_x(moveSpeed, _dir);
		var _vsp = lengthdir_y(moveSpeed, _dir);
	
		//currently no environment collisions
		//cause Im bad at them
	
		//commit movement
		x += _hsp;
		y += _vsp;
	
	}
	
	function EnemyStateExplode(){
	
		//create the variable if not set yet
		if !variable_instance_exists(id, "explodeCd") explodeCd = 60;
	
		//countdown until destruction
		explodeCd = Approach(explodeCd, 0, 1);
		if explodeCd <= 0 {
			instance_destroy();
		
			//increase enemy defeated count
			global.enemyDefeated = Approach(global.enemyDefeated, global.enemyDefeatedReqCurrent, 1);
			
			//check for boss
			if (object_index == objEnemyBoss) DialogueStart(DLG_SEQ_OUTRO, GameStateCredits);
			
		}
	
	}
	
	function EnemyStateLocked(){
	
	}
	
	function EnemyStateSpawned(){
	
		//wait a little after spawning
		waitCd = Approach(waitCd, 0, 1);
		if waitCd <= 0 {
		
			enemyState = enemyStateTarget;
			damageActive = true;
			image_blend = c_white;
		
		} else image_blend = c_gray;
	
	}
	
	function EnemyStateThrown(){
		
		//precation
		if !variable_instance_exists(id, "throwDirection") throwDirection = 0;
		if !variable_instance_exists(id, "throwSpeed") throwSpeed = 0;
		if !variable_instance_exists(id, "throwTimer") throwTimer = 0;
		
		//fly
		var _hsp = lengthdir_x(throwSpeed, throwDirection);
		var _vsp = lengthdir_y(throwSpeed, throwDirection);
		x += _hsp;
		y += _vsp;
		
		throwTimer = Approach(throwTimer, 0, 1);
		if throwTimer <= 0 {
			
			//move to normal behavior
			enemyState = enemyStateTarget;
			damageActive = true;
			image_blend = c_white;
			
		}
		
	}
	
#endregion

#region states for normal enemies

	function EnemyStateDefault(){
	
		//quit if player is gone
		if !instance_exists(objPlayer) exit;
	
		//get player position
		var _x = 0, _y = 0;
		with objPlayer {
			_x = x;
			_y = y;
		}
		
		//only movement
		EnemyMoveTo(_x,_y);
	
	}


	function EnemyStateDashLocate(){
	
		//quit if player is gone
		if !instance_exists(objPlayer) exit;
	
		//get player position
		var _x = 0, _y = 0;
		with objPlayer {
			_x = x;
			_y = y;
		}
		
		//movement
		EnemyMoveTo(_x,_y);
	
	
		//check distance
		var _dist = point_distance(x,y, _x,_y);
		if _dist <= dashReadyDist {
			
			//start charging
			dashCharge = dashChargeMax;
			enemyState = EnemyStateDashCharge;
			
		}
	
	}

	function EnemyStateDashCharge(){
	
		//quit if player is gone
		if !instance_exists(objPlayer) exit;
	
		//charge dash (just a cooldown)
		dashCharge = Approach(dashCharge, 0, 1);
		if dashCharge <= 0 {
		
			//move to active dashing
			dashTimer = dashTimerMax;
			enemyState = EnemyStateDashActive;
			
			//sfx
			SoundPlay(sfxEnemyDash);
		
		}
	
	
		//get player position
		var _x = 0, _y = 0;
		with objPlayer {
			_x = x;
			_y = y;
		}
	
		//follow player
		dashDirection = point_direction(x,y, _x,_y);
	
	}

	function EnemyStateDashActive(){
	
		//just move (no collision as usual)
		x += lengthdir_x(dashSpeed, dashDirection);
		y += lengthdir_y(dashSpeed, dashDirection);
	
		//countdown dash
		dashTimer = Approach(dashTimer, 0, 1);
		if dashTimer <= 0 {
		
			//introduce cd before next dash
			waitCd = 60;
			enemyState = EnemyStateDashCooldown;
		
		}
	
	}

	function EnemyStateDashCooldown(){
	
		//wait a little in between dashes
		waitCd = Approach(waitCd, 0, 1);
		if waitCd <= 0 {
		
			enemyState = EnemyStateDashLocate;
		
		}
	
	}


	function EnemyStateTrapLocate(){
	
		//quit if player is gone
		if !instance_exists(objPlayer) exit;
	
		//get player position
		var _x = 0, _y = 0;
		with objPlayer {
			_x = x;
			_y = y;
		}
		
		//movement
		EnemyMoveTo(_x,_y);
		
		
		//trap cd
		trapCd = Approach(trapCd, 0, 1);
		if trapCd <= 0 {
			
			trapCharge = trapChargeMax;
			enemyState = EnemyStateTrapCharge;
			
		}
	
	}

	function EnemyStateTrapCharge(){
	
		//spin in place before spawning a trap
		trapCharge = Approach(trapCharge, 0, 1);
		if trapCharge <= 0 {
		
			instance_create_layer(x,y, "Traps", objEnemyTrapTile);
			trapCd = trapCdMax;
			enemyState = EnemyStateTrapLocate;
		
		}
	
	}

#endregion

#region boss states
	
	function EnemyStateBossLocate(){
		
		//spin
		image_speed = 1;
		
		//quit if player is gone
		if !instance_exists(objPlayer) exit;
		
		//get player position
		var _x = 0, _y = 0;
		with objPlayer {
			_x = x;
			_y = y;
		}
		
		//setup direction
		var _dir = point_direction(x,y, _x,_y);
		_dir += moveShiftDirection;
		
		//apply movement
		var _hsp = lengthdir_x(moveSpeed, _dir);
		var _vsp = lengthdir_y(moveSpeed, _dir);
		x += _hsp;
		y += _vsp;
		
		//change zig zag direction
		moveShiftCd = Approach(moveShiftCd, 0, 1);
		if moveShiftCd <= 0 {
			
			//zig zag shift
			moveShiftDirection = -moveShiftDirection;
			moveShiftCd = moveShiftCdMax;
			
		}
		
		
		//check distance
		var _dist = point_distance(x,y, _x,_y);
		if _dist <= throwReadyDist && throwCd <= 0 {
			
			//stop spinning
			image_index = 0;
			image_speed = 0;
			
			//choose a random enemy
			var _enemyType = choose(objEnemyDefault, objEnemyDash, objEnemyTrap);
			var _enemyId = instance_create_layer(x+throwEnemyShiftX,y+throwEnemyShiftY, "Enemy", _enemyType);
			_enemyId.enemyState = EnemyStateLocked;
			_enemyId.enemyStatePrev = EnemyStateLocked;
			
			//save enemy id
			throwEnemyId = _enemyId;
			
			//start charging
			throwCharge = throwChargeMax;
			enemyState = EnemyStateBossThrowCharge;
			
			//play sfx
			SoundPlay(sfxEnemyBossCharge);
			
		}
		
		//throw cooldown
		throwCd = Approach(throwCd, 0, 1);
		
	}
	
	function EnemyStateBossThrowCharge(){
	
		//quit if player is gone
		if !instance_exists(objPlayer) exit;
	
		//charge a throw
		throwCharge = Approach(throwCharge, 0, 1);
		if throwCharge <= 0 {
			
			//throw the bastard
			with throwEnemyId {
				
				image_blend = c_white;
				damageActive = true;
				enemyState = EnemyStateThrown;
				
				throwDirection = other.throwDirection;
				throwSpeed = 8;
				throwTimer = 60;
				
				//sfx
				SoundPlay(sfxEnemyBossThrow);
				
			}
			
			//repeat
			image_speed = 1;
			enemyState = EnemyStateBossLocate;
			throwCd = throwCdMax;
		
		}
	
		//get player position
		var _x = 0, _y = 0;
		with objPlayer {
			_x = x;
			_y = y;
		}
	
		//follow player
		throwDirection = point_direction(x,y, _x,_y);
		
		//move away from player
		var _dirReverse = point_direction(_x,_y, x,y);
		var _hsp = lengthdir_x(moveSpeed/2, _dirReverse);
		var _vsp = lengthdir_y(moveSpeed/2, _dirReverse);
		x += _hsp;
		y += _vsp;
		
		
		//hold the bastard
		throwEnemyId.x = x + throwEnemyShiftX;
		throwEnemyId.y = y + throwEnemyShiftY;
		
		//recolor bastard based on charge level
		if (throwCharge < throwChargeMax*2/3) throwEnemyId.image_blend = c_orange;
		if (throwCharge < throwChargeMax/3) throwEnemyId.image_blend = c_red;
		
	}
	
	
#endregion