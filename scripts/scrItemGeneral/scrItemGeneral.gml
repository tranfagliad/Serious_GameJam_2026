function ItemOrbit(_x, _y, _spinSpeed){
	
	//set speed
	orbitSpeed = _spinSpeed*orbitSpeedMult;
	
	//orbit
	orbitAngle += orbitSpeed;
	if orbitAngle > 360 orbitAngle -= 360;
	if orbitAngle < 0	orbitAngle += 360;
	
	//set position
	x = _x + lengthdir_x(orbitDist, orbitAngle);
	y = _y + lengthdir_y(orbitDist, orbitAngle);
	
	
	//rotate itself
	image_angle += itemSpinSpeed;
	if image_angle > 360	image_angle -= 360;
	if image_angle < 0		image_angle += 360;
	
}

function ItemObjectCreate(_type){
	
	//set position
	var _x = 0, _y = 0;
	with objPlayer {
		
		_x = x;
		_y = y;
		
	}
	
	//creeate object
	switch _type {
		
		//do not create paper
		case "staplers": instance_create_layer(_x, _y, "Player", objItemStapler); break;
		case "computers": instance_create_layer(_x, _y, "Player", objItemComputer); break;
		
	}
	
}

function ItemPapersTriggerDisperse(_x,_y){
	
	var _num = 5;
	for (var i = 0; i < _num; i++) {
		
		var _item = instance_create_layer(_x,_y, "Player", objItemPaper);
		with _item {
			
			x = _x;
			y = _y;
			
			image_angle = 0;
			image_index = 0;
			image_speed = 0;
			
			itemState = ItemStateDisperse;
			dashSpeed = 2;
			dashDirection = 360*i/_num;
			
		}
		
	}
	
}

function ItemExplode(){
	
	switch sprite_index {
		case sprStapler: image_xscale = 0.5; image_yscale = 0.5;
	}
	
	sprite_index = sprExplosion;
	image_index = 0;
	image_speed = 1;
	
	explodeCd = 15;
	itemState = ItemStateExplode;
	
}