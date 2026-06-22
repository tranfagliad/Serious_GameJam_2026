function ItemStateOrbit(){
	
	if instance_exists(followId) {
	
		//orbit around player
		ItemOrbit(followId.x, followId.y, followId.spinSpeed);
	
		//collision with enemies
		var _enId = instance_place(x,y, objEnemyParent);
		if instance_exists(_enId) && _enId.damageActive {
		
			//damage enemy
			with _enId EnemyHit(other.damage);
		
			//explode
			ItemExplode();
			
			//remove item from inventory
			switch object_index {
				
				default:				global.inventory.papers = Approach(global.inventory.papers, 0, 1);			break;
				case objItemStapler:	global.inventory.staplers = Approach(global.inventory.staplers, 0, 1);		break;
				case objItemComputer:	global.inventory.computers = Approach(global.inventory.computers, 0, 1);	break;
				
			}
		
		}
	
	}
	
}

function ItemStateExplode(){
	
	//create the variable if not set yet
	if !variable_instance_exists(id, "explodeCd") explodeCd = 15;
	
	//countdown until destruction
	explodeCd = Approach(explodeCd, 0, 1);
	if explodeCd <= 0 instance_destroy();
	
}

function ItemStateDash(){
	
	//precaution
	if !variable_instance_exists(id, "dashDirection") dashDirection = 0;
	if !variable_instance_exists(id, "dashSpeed") dashSpeed = 1;
	
	//movement
	x += lengthdir_x(dashSpeed, dashDirection);
	y += lengthdir_y(dashSpeed, dashDirection);
	
	//enemy collision
	var _enId = instance_place(x,y, objEnemyParent);
	if instance_exists(_enId) {
		
		//damage enemy
		with _enId if damageActive EnemyHit(other.damage);
		
		//explode
		ItemExplode();
		
	}
	
	//out of bounds
	if (x < 0 || x > room_width || y < 0 || y > room_height) instance_destroy();
	
}