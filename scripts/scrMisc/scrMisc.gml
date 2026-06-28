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

//get a random position from array based on chance weigths
function RandomWeights(_weigthsArray){
	
	//get length of original weigths
	var _al = array_length(_weigthsArray);
	
	//setup default result as final position
	var _position = _al - 1;
	
	
	//setup weigths array and a total (adds all previous modificators to every next one)
	var _wTotal = 0;
	var _weigths = [];
	for (var i = 0; i < _al; i++) {
			
		//get modificator
		var _mod = _weigthsArray[i];
			
		//add modificator to total
		_wTotal += _mod;
			
		//set new value as weigth for current position
		_weigths[i] = _wTotal;
			
	}
	
	
	//get a random number between 0 and a total (real)
	var _r = random_range(0, _wTotal);
	
	//check left to right each new weigth position
	for (var j = 0; j < _al; j++) {
		
		//get weigth
		var _weigth = _weigths[j];
		
		//check if random number is within range
		if (_r < _weigth) {
			
			//set chosen position
			_position = j;
			
			//stop looping instantly
			break;
			
		}
		
	}
	
	//for example, an array of original weigths is [2, 0, 1, 4]
	//final weigths is current value + each previous value combined so it will be [2, 2, 3, 7]
	//random number will be between (0, 7)
	//if number < 2 it will return 1 position and stop
	//if number between 2 and 3 it will return 3 position and stop
	//if number between 3 and 7 it will return 4 position and stop
	//all exceptions lead to it returning 4 position
	
	
	//return chosen position
	return _position;
	
}