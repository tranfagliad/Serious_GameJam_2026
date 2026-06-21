//approach one number to another
function Approach(_val, _newVal, _speed){
		
	var _side = "Equal";
	if (_val > _newVal) _side = "More";
	if (_val < _newVal) _side = "Less";
		
	switch _side {
			
		//old value is more than needed
		case "More": {
			_val -= _speed;
			if (_val <= _newVal) _val = _newVal;
		} break;
			
		//old value is less than needed
		case "Less": {
			_val += _speed;
			if (_val >= _newVal) _val = _newVal;
		} break;
			
	}
		
	return _val;
	
}