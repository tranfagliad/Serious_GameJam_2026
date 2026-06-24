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
	
	
	//get sequence layer to follow camera
	if layer_exists("Transition") {
		
		//setup layer elements
		var _trLay = layer_get_id("Transition");
		var _eIds = layer_get_all_elements(_trLay);
	
		//if array of elements on the layer has at least 1 element check if its a sequence
		//and check if it exists (double check idk) then set its x and y positions
		if (array_length(_eIds) > 0) {
			var _eId = _eIds[0];
			var _eType = layer_get_element_type(_eId);
		
			if (_eType == layerelementtype_sequence) && layer_sequence_exists(_trLay, _eId) {
				
				//set position
				layer_sequence_x(_eId, _camX);
				layer_sequence_y(_eId, _camY);
				
				//update scale with zoom
				layer_sequence_xscale(_eId, zoomFactor);
				layer_sequence_yscale(_eId, zoomFactor);
				
			}
		}
	}
	
}