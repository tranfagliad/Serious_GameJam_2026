//quick dialogue creation in a single line
function DataDialogueSet(_struct, _seq, _num, _name = "", _text = "", _color = c_white, _portraitNum = -1, _sfx = sfxText, _speed = 0.7, _alpha = 1){
	
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
		
	#region	test
			
		//test
		DataDialogueSet(_data, DLG_SEQ_TEST, 0,	"Name",	"Short Text", _cDef,	0);
		DataDialogueSet(_data, DLG_SEQ_TEST, 1,	"Loooooong Assssssssssss Name",	"Very very long Text Very very long Text Very very long Text Very very long Text Very very long Text Very very long Text Very very long Text", _cDef,	0);
		
	#endregion
	
	#region	intro cutscene
		// Introduction sequence with varying portraits and line breaks
		DataDialogueSet(_data, DLG_SEQ_INTRO, 0, "Narrator", "Samsara. The ongoing cycle of life, death, and rebirth.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 1, "Narrator", "An office worker, deprived of all joy. Shackled to earthly responsibilities. Starved of purpose. Hungry ghosts trapped in the endless cycle of Samsara.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 2, "Hughes", "Nirvana... I cannot find it here. I suffer in silence. No. No! I must break free!", _cDef, 1);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 3, "Narrator", "Use WASD to move and charge up your spin.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 4, "Narrator", "At full charge, press [SPACE] to dash.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 5, "Narrator", "Defend yourself with office supplies...\n* Use staplers and computers to attack.\n* Use paper to protect yourself.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 6, "Narrator", "Good luck!", _cDef, 0);
	#endregion
	
	#region   // Level Two
		//DataDialogueSet(_data, DLG_SEQ_LVL_TWO, 0, "Hughes", "This is Level 2... Whatever that means", _cDef,	1);
	#endregion
	
	#region   // Level Three
		//DataDialogueSet(_data, DLG_SEQ_LVL_THREE, 0, "Hughes", "Level 3, I'm almost there", _cDef,	1);
	#endregion
	
	#region   // Boss Level
		DataDialogueSet(_data, DLG_SEQ_LVL_BOSS, 0,	"Ms. Snide", "My company... in ruins!", _cDef,	2);
		DataDialogueSet(_data, DLG_SEQ_LVL_BOSS, 1,	"Ms. Snide", "You dare say you approach Nirvana through this destruction?", _cDef,	2);
		DataDialogueSet(_data, DLG_SEQ_LVL_BOSS, 2,	"Ms. Snide", "I'll show you the truth of who you are!", _cDef,	2);
	#endregion
	
	//return structure of datasets
	return _data;
		
}