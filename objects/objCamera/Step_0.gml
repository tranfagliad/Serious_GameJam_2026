//do not move camera during pause
if !global.gamePaused {

	// Pan Camera
	if instance_exists(followTarget) {
		x = lerp(x, followTarget.x, CAMERA_PAN_SPEED);
		y = lerp(y, followTarget.y, CAMERA_PAN_SPEED);
	}
	
	var _camX = x - (zoomWidth / 2);
	var _camY = y - (zoomHeight / 2);
	
	camera_set_view_pos(view_camera[0], _camX, _camY);
}