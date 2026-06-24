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


function EnemyStateDefault(){
	
	//quit if player is gone
	if !instance_exists(objPlayer) exit;
	
	//wait a little after spawning
	waitCd = Approach(waitCd, 0, 1);
	if waitCd <= 0 {
		
		//get player position
		var _x = 0, _y = 0;
		with objPlayer {
			_x = x;
			_y = y;
		}
		
		//only movement
		EnemyMoveTo(_x,_y);
	
	}
	
}

function EnemyStateDashLocate(){
	
	//quit if player is gone
	if !instance_exists(objPlayer) exit;
	
	//wait a little after spawning
	waitCd = Approach(waitCd, 0, 1);
	if waitCd <= 0 {
		
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
		enemyState = EnemyStateDashLocate;
		
	}
	
}



function EnemyStateExplode(){
	
	//create the variable if not set yet
	if !variable_instance_exists(id, "explodeCd") explodeCd = 60;
	
	//countdown until destruction
	explodeCd = Approach(explodeCd, 0, 1);
	if explodeCd <= 0 instance_destroy();
	
}
	
function EnemyStateLocked(){
	
}