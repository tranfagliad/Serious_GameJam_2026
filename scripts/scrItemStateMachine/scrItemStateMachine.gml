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
			explodeCd = 15;
			sprite_index = sprPlaceholderExplosion;
			itemState = ItemStateExplode;
			
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
	
	if instance_exists(followId) {
	
		//still orbit
		ItemOrbit(followId.x, followId.y, followId.spinSpeed);
	
		//create the variable if not set yet
		if !variable_instance_exists(id, "explodeCd") explodeCd = 15;
	
		//countdown until destruction
		explodeCd = Approach(explodeCd, 0, 1);
		if explodeCd <= 0 instance_destroy();
	
	}
	
}