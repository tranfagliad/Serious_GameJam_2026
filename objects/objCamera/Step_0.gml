
//do not move camera during pause
if !global.gamePaused {

	// Pan Camera
	if instance_exists(followTarget) {
	
		x = lerp(x, followTarget.x, CAMERA_PAN_SPEED);
		y = lerp(y, followTarget.y, CAMERA_PAN_SPEED);
	
	}
	camera_set_view_pos(view_camera[0], x-(VIEWPORT_WIDTH/4), y-(VIEWPORT_HEIGHT/4));

}