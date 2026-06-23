
//do not move camera during pause
if !global.gamePaused {

	// Pan Camera
	if instance_exists(followTarget) {
	
		x = lerp(x, followTarget.x, CAMERA_PAN_SPEED);
		y = lerp(y, followTarget.y, CAMERA_PAN_SPEED);
	
	}
	
	//center camera
	var _camX = x-(VIEWPORT_WIDTH/4);
	var _camY = y-(VIEWPORT_HEIGHT/4);
	camera_set_view_pos(view_camera[0], _camX, _camY);

}