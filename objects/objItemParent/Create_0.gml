followId = objPlayer;

orbitSpeed = 1;
orbitDist = PLAYER_WIDTH + 32;
orbitAngle = random(360);
itemSpinSpeed = random_range(-5,5);

//set position
if instance_exists(followId) {
	
	x = followId.x + lengthdir_x(PLAYER_WIDTH, orbitAngle);
	y = followId.y + lengthdir_y(PLAYER_WIDTH, orbitAngle);
	
}