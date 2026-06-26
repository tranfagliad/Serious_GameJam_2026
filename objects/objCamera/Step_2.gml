if !global.gamePaused {

	// Pan Camera coordinates safely
	if (followTarget != noone) && (instance_exists(followTarget)) {
		x = lerp(x, followTarget.x, CAMERA_PAN_SPEED);
		y = lerp(y, followTarget.y, CAMERA_PAN_SPEED);
	}
	
	var _camX = camera_get_view_x(cam);
	var _camY = camera_get_view_y(cam);

	var _targetX = 0;
	var _targetY = 0;
	
	// Calculate look-at targets only if reference is present
	if (followTarget != noone) && (instance_exists(followTarget)) {
		_targetX = (followTarget.x - VIEWPORT_WIDTH*zoomFactor/2);
		_targetY = (followTarget.y - VIEWPORT_HEIGHT*zoomFactor/2);
	}

	_camX = lerp(_camX, _targetX, CAMERA_PAN_SPEED);
	_camY = lerp(_camY, _targetY, CAMERA_PAN_SPEED);

	_camX = round(_camX);
	_camY = round(_camY);

	var _camCoords = ScreenShake(_camX, _camY);
	_camX = _camCoords[0];
	_camY = _camCoords[1];

	camera_set_view_pos(cam, _camX, _camY);
	
	// Only scale zoom dynamically based on player speed parameters
	if (followTarget != noone) && (instance_exists(followTarget)) {
		UpdateZoomGetSpeed();
	}
	UpdateZoom();
	
	// Keep your transition layer sequence sync code exactly as it is below
	if layer_exists("Transition") {
		var _trLay = layer_get_id("Transition");
		var _eIds = layer_get_all_elements(_trLay);
		if (array_length(_eIds) > 0) {
			var _eId = _eIds[0];
			var _eType = layer_get_element_type(_eId);
			if (_eType == layerelementtype_sequence) && layer_sequence_exists(_trLay, _eId) {
				if (followTarget != noone) && (instance_exists(followTarget)) layer_sequence_x(_eId, _camX); else layer_sequence_x(_eId, 0);
				if (followTarget != noone) && (instance_exists(followTarget)) layer_sequence_y(_eId, _camY); else layer_sequence_y(_eId, 0);
				if (followTarget != noone) && (instance_exists(followTarget)) layer_sequence_xscale(_eId, zoomFactor); else layer_sequence_xscale(_eId, 1);
				if (followTarget != noone) && (instance_exists(followTarget)) layer_sequence_yscale(_eId, zoomFactor); else layer_sequence_xscale(_eId, 1);
			}
		}
	}
}
