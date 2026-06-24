//reset zoom
zoomFactor = 0.5;

//snap camera to player upon arrival to mitigate camera flying from 0,0 to new position slowly
if (followTarget != noone) && (instance_exists(followTarget)) {
	//get the player position
	var _camX = (followTarget.x - VIEWPORT_WIDTH*zoomFactor/2);
	var _camY = (followTarget.y - VIEWPORT_HEIGHT*zoomFactor/2);
	
	//clamp target position to room bounds
	//_camX = clamp(_camX,0,room_width - VIEWPORT_WIDTH);
	//_camY = clamp(_camY,0,room_height - VIEWPORT_HEIGHT);
	
	//round the positions
	_camX = round(_camX);
	_camY = round(_camY);
	
	camera_set_view_pos(cam,_camX,_camY);
}

//update zoom
UpdateZoom();