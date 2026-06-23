//quick dialogue creation in a single line
function DataDialogueSet(_struct, _seq, _num, _name = "", _text = "", _color = c_white, _sfx = noone, _portraitNum = -1, _speed = 0.7, _alpha = 1){
	
	//initiate sequence data
	if !struct_exists(_struct, _seq) {
		_struct[$ _seq ] = {};
	}
				
	//add a line data
	_struct[$ _seq ][$ string_concat(_seq, string(_num))] = {};
	_struct[$ _seq ][$ string_concat(_seq, string(_num))][$ DLG_NAME]		= _name;
	_struct[$ _seq ][$ string_concat(_seq, string(_num))][$ DLG_PORTRAIT]	= _portraitNum;
	_struct[$ _seq ][$ string_concat(_seq, string(_num))][$ DLG_TEXT]		= _text;
	_struct[$ _seq ][$ string_concat(_seq, string(_num))][$ DLG_COLOR]		= _color;
	_struct[$ _seq ][$ string_concat(_seq, string(_num))][$ DLG_SFX]		= _sfx;
	_struct[$ _seq ][$ string_concat(_seq, string(_num))][$ DLG_SPEED]		= _speed;
	_struct[$ _seq ][$ string_concat(_seq, string(_num))][$ DLG_ALPHA]		= _alpha;
	
}

//make struct of dialogue sequences
function DataCreateDialogue(){
		
	//setup struct of datasets
	var _data = {};
	
	//colors for dialogue
	var _cDef = c_white;
		
	#region	intro sequences
			
		//test
		DataDialogueSet(_data, DLG_SEQ_TEST, 0,	"Name",	"Short Text", _cDef,	noone,	0);
		DataDialogueSet(_data, DLG_SEQ_TEST, 1,	"Loooooong Assssssssssss Name",	"Very very long Text Very very long Text Very very long Text Very very long Text Very very long Text Very very long Text Very very long Text", _cDef,	noone,	0);
		
	#endregion
	
	//return structure of datasets
	return _data;
		
}