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