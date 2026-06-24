//length is in frames, magnitude in pixels
function ScreenShakeStart(_length, _magnitude){
	
	//check a global flag
	if global.screenShakeActive {
	
		//limit magnitude
		_magnitude = min(_magnitude, 32);
	
		with objCamera {
		
			//only checks for new shake to be stronger in magnitude to replace old shake
			if (_magnitude > camShakeRemain) {
				camShakeMagnitude = _magnitude;
				camShakeRemain = _magnitude;
				camShakeLength = _length;
			}
		
		}
	
	}
	
}