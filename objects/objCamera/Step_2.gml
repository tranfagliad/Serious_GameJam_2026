//do not move camera during pause
if !global.gamePaused {

	// Pan Camera
	if instance_exists(followTarget) {
		x = lerp(x, followTarget.x, CAMERA_PAN_SPEED);
		y = lerp(y, followTarget.y, CAMERA_PAN_SPEED);
	}
	
	//get current camera position
	var _camX = camera_get_view_x(cam);
	var _camY = camera_get_view_y(cam);

	//set target camera position
	var _targetX = 0;
	var _targetY = 0;
	if (followTarget != noone) && (instance_exists(followTarget)) {
	
		_targetX = (followTarget.x - VIEWPORT_WIDTH*zoomFactor/2);
		_targetY = (followTarget.y - VIEWPORT_HEIGHT*zoomFactor/2);
	
	}

	//clamp target position to room bounds
	//_targetX = clamp(_targetX,0,room_width - VIEWPORT_WIDTH);
	//_targetY = clamp(_targetY,0,room_height - VIEWPORT_HEIGHT);

	//move camera to target position
	_camX = lerp(_camX, _targetX, CAMERA_PAN_SPEED);
	_camY = lerp(_camY, _targetY, CAMERA_PAN_SPEED);

	//round the positions (flooring causes weird interaction with screen shake)
	_camX = round(_camX);
	_camY = round(_camY);

	//screen shake
	var _camCoords = ScreenShake(_camX,_camY);
	_camX = _camCoords[0];
	_camY = _camCoords[1];

	//apply camera position
	camera_set_view_pos(cam,_camX,_camY);
	
	//update zoom
	UpdateZoomGetSpeed();
	UpdateZoom();
	
}