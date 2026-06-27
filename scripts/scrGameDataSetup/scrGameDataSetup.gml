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
		DataDialogueSet(_data, DLG_SEQ_INTRO, 0, "Hughes", "I just got an email.", _cDef, 1);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 1, "Hughes", "*...click...click.*", _cDef, 1);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 2, "Hughes", "The CEO just fired me?!", _cDef, 1);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 3, "Hughes", "...", _cDef, 1);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 4, "Hughes", "I'm gonna spin that snake through a wall...", _cDef, 1);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 5, "Tutorial", "Use WASD to move and charge up your spin.\nMaintain high spin to create a tornado around you to pick up objects.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 6, "Tutorial", "At full charge, press [SPACE] to dash.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 7, "Tutorial", "Paper provides you with protection.\nStaplers provide a means to attack.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 8, "Tutorial", "Computers deal massive damage and can be hurled as projectiles.\nThey are launched in the direction that you dash.", _cDef, 0);
		DataDialogueSet(_data, DLG_SEQ_INTRO, 9, "Tutorial", "Good luck!", _cDef, 0);
	#endregion
	
	#region   // Level Two
		DataDialogueSet(_data, DLG_SEQ_LVL_TWO, 0, "Hughes", "Sales, always failing their pitch. Maybe they should pivot?", _cDef,	1);
	#endregion
	
	#region   // Level Three
		DataDialogueSet(_data, DLG_SEQ_LVL_THREE, 0, "Hughes", "Human Resources, more like... human revolution.", _cDef,	1);
	#endregion
	
	#region   // Boss Level
		DataDialogueSet(_data, DLG_SEQ_LVL_BOSS, 0,	"Ms. Snide", "Oh...? Here to beg for your job?", _cDef,	2);
		DataDialogueSet(_data, DLG_SEQ_LVL_BOSS, 1,	"Hughes", "No, I-", _cDef,	1);
		DataDialogueSet(_data, DLG_SEQ_LVL_BOSS, 2,	"Ms. Snide", "Ssssshut up! Peons!", _cDef,	2);
		DataDialogueSet(_data, DLG_SEQ_LVL_BOSS, 3,	"Ms. Snide", "Ssssspin this fool into orbit!", _cDef,	2);
	#endregion
	
	#region
		DataDialogueSet(_data, DLG_SEQ_OUTRO, 0, "Dev Team", "Thanks for playing! We hope you are enjoying the game jam!", _cDef, 3);
	#endregion
	
	//return structure of datasets
	return _data;
		
}
