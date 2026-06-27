if !global.midTransition image_speed = 1;
if image_index >= 8 && !smokeCreated {
	var _smoke = instance_create_layer(x,y+sprite_height/2,"Enemy", objEnemyBossSmoke);
	_smoke.depth = depth - 5;
	smokeCreated = true;
}