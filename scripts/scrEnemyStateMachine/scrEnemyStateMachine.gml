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
	
		//calculate movement towards player
		var _dir = point_direction(x,y, _x,_y);
		var _hsp = lengthdir_x(moveSpeed, _dir);
		var _vsp = lengthdir_y(moveSpeed, _dir);
	
		//currently no environment collisions
		//cause Im bad at them
	
		//commit movement
		x += _hsp;
		y += _vsp;
	
	}
	
}

function EnemyStateExplode(){
	
	//create the variable if not set yet
	if !variable_instance_exists(id, "explodeCd") explodeCd = 90;
	
	//countdown until destruction
	explodeCd = Approach(explodeCd, 0, 1);
	if explodeCd <= 0 instance_destroy();
	
}