cam = view_camera[0];
followTarget = objPlayer;
//x = followTarget.x;	moved this to room start
//y = followTarget.y;



// I like it
zoomFactorMin = 0.5;
zoomFactorMax = 1;
zoomFactor = 1;   // Bigger number = more zoomed out


//zoom based on spin speed
UpdateZoomGetSpeed = function(){
	
	//check player
	if followTarget == objPlayer {
		
		//get spin
		var _spd = followTarget.spinSpeed;
		var _spdMax = followTarget.maxSpinSpeed;
		var _zoomFactorTarget = zoomFactorMin + (_spd/_spdMax)*0.5;
		
		//apply spin
		zoomFactor = Approach(zoomFactor, _zoomFactorTarget, 0.005);
		zoomFactor = clamp(zoomFactor, zoomFactorMin, zoomFactorMax);
		
	}
	
}

//dynamic zoom
UpdateZoom = function(){
	
	var view_w = camera_get_view_width(cam);
	var view_h = camera_get_view_height(cam);

	//Get new sizes by interpolating current and target zoomed size
	var new_w = zoomFactor * VIEWPORT_WIDTH;
	var new_h = zoomFactor * VIEWPORT_HEIGHT;

	//Apply the new size
	camera_set_view_size(cam, new_w, new_h);
	//surface_resize(application_surface,new_w, new_h);
	//display_set_gui_size(new_w, new_h);
	
	//get camera position
	var vpos_x = camera_get_view_x(cam);
	var vpos_y = camera_get_view_y(cam);

	//change coordinates of camera so zoom is centered
	var new_x = vpos_x+(view_w - zoomFactor * VIEWPORT_WIDTH)/2;
	var new_y = vpos_y+(view_h - zoomFactor * VIEWPORT_HEIGHT)/2;
	
	//update position
	camera_set_view_pos(cam, floor(new_x), floor(new_y));
	
}


//screen shake code
camShakeLength = 0;
camShakeMagnitude = 0;
camShakeRemain = 0;

ScreenShake = function(_camX,_camY) {
	
	if (camShakeRemain > 0) { //need to check for html (AS USUAL FUCKING JAVASCRIPT)
		
		_camX += random_range( -camShakeRemain, camShakeRemain);
		_camY += random_range( -camShakeRemain, camShakeRemain);
		
		camShakeRemain = max(0, camShakeRemain - ( (1/camShakeLength)*camShakeMagnitude ) );
		
	}
	
	//return the coordinates as an array cause IDK
	var _camCoords = [_camX, _camY];
	return _camCoords;
	
}