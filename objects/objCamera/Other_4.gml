// Reset zoom
zoomFactor = 0.5;

// Only snap position if target exists
if (followTarget != noone) && (instance_exists(followTarget)) {
	var _camX = (followTarget.x - VIEWPORT_WIDTH*zoomFactor/2);
	var _camY = (followTarget.y - VIEWPORT_HEIGHT*zoomFactor/2);
	
	_camX = round(_camX);
	_camY = round(_camY);
	camera_set_view_pos(cam, _camX, _camY);
} else {
	// Defensively position the camera at (0,0) for menus or splash screens
	camera_set_view_pos(cam, 0, 0);
}

// Update zoom
UpdateZoom();