//manual wrapping for text (thanks tutorials)
function TextWrap(_text, _width){
	
	draw_set_font(fntConsolBig);
	var _text_wrapped = "";
	var _space = -1;
	var _char_pos = 1;
	
	
	while (string_length(_text) >= _char_pos) {
			
		if (string_width(string_copy(_text, 1, _char_pos)) > _width) {
				
		    if (_space != -1) {
					
		        _text_wrapped += string_copy(_text, 1, _space) + "\n";
		        _text = string_copy(_text, _space + 1, string_length(_text) - (_space));
		        _char_pos = 1;
		        _space = -1;
					
		    }
					
		}
			
		if (string_char_at(_text,_char_pos) == " ") {
		    _space = _char_pos;
		}
		_char_pos += 1;
			
	}
		
	if (string_length(_text) > 0) {
		_text_wrapped += _text;
	}
	
	
	return _text_wrapped;
	
}

//setup dialogue object parameters
function DialogueSet(_sequence){
	
	//reset everything
	textCol = c_white;
	textSfx = noone;
	textAlpha = 1;
	textSpeed = 1;
	textMessage = "";
	textLength = 0;
	textProgress = 1;
		
	//setup sequence
	dlgSq = _sequence;
	dlgSqPos = 0;
		
	//progress text
	DialogueProgress();
	
}

//progress dialogue
function DialogueProgress(){
	//check if sequence is set
	if (dlgSq != "") {
			
		//get sequence
		var _sqData = global.dataDialogue[$ dlgSq] ?? {};
			
		//check if sequence finished
		var _sqL = struct_names_count(_sqData);
		if (dlgSqPos >= _sqL) {
				
			//stop dialogue
			dlgSq = "";
			textboxState = TextboxStateDissappear;
				
		} else {
				
			//get text and wrap it
			textMessage = _sqData[$ string_concat(dlgSq, string(dlgSqPos))][$ DLG_TEXT] ?? "";
			textMessage = TextWrap(textMessage, textW);
				
			//get line color, alpha, speed, and text length
			textCol = _sqData[$ string_concat(dlgSq, string(dlgSqPos))][$ DLG_COLOR]	?? c_white;
			textSfx = _sqData[$ string_concat(dlgSq, string(dlgSqPos))][$ DLG_SFX]		?? noone;
			textAlpha = _sqData[$ string_concat(dlgSq, string(dlgSqPos))][$ DLG_ALPHA]	?? 1;
			textSpeed = _sqData[$ string_concat(dlgSq, string(dlgSqPos))][$ DLG_SPEED]	?? 1;
			textLength = string_length(textMessage);
				
				
			//destroy all followers
			with objTextboxFollower instance_destroy();
			
			//create the name
			var _name = _sqData[$ string_concat(dlgSq, string(dlgSqPos))][$ DLG_NAME] ?? "";
			if (_name != "") {
				
				draw_set_font(fntConsolBig);
				var _xScale = (string_width(_name) + 16)/sprite_get_width(sprTextbox);
				var _yScale = 0.75*2;
					
				var _xShift = -sprite_get_width(sprTextbox)*4 - 2;
				var _yShift = -sprite_get_height(sprTextbox)*_yScale - 2;
					
				var _tn = instance_create_layer(x + _xShift,y + _yShift, "System", objTextboxName);
				with _tn {
						
					image_xscale = _xScale;
					image_yscale = _yScale;
						
					shiftX = _xShift;
					shiftY = _yShift;
						
					textMessage = _name;
					textCol = other.textCol;
						
					textX = 8;
					textY = floor(sprite_get_height(sprTextbox)*_yScale/2 - string_height(_name)/2);
						
				}
					
			}
			
			
			//create the portrait
			var _portrait = _sqData[$ string_concat(dlgSq, string(dlgSqPos))][$ DLG_PORTRAIT] ?? -1;
			if (_portrait >= 0) {
					
				var _xScale = 4;
				var _yScale = 4;
					
				var _xShift = -sprite_get_height(sprTextbox)*_xScale - 2;
				var _yShift = 0;
					
				var _tn = instance_create_layer(x + _xShift,y + _yShift, "System", objTextboxPortrait);
				with _tn {
						
					image_xscale = _xScale;
					image_yscale = _yScale;
						
					shiftX = _xShift;
					shiftY = _yShift;
						
					portraitNum = _portrait;
						
				}
					
			}
			
			//progress dialogue for next check
			dlgSqPos += 1;
				
		}	
			
	} else {
			
		//stop dialogue
		textboxState = TextboxStateDissappear;
			
	}
}

//create dialogue
function DialogueStart(_seq, _stateTarget){
	
	//remove all textbox objects
	DialogueClean();
	
	//setup position and scale
	var _x = 144;
	var _y = VIEWPORT_HEIGHT - 128 - 8;
	
	var _xScale = (VIEWPORT_WIDTH - 144 - 16)/sprite_get_width(sprTextbox);
	var _yScale = 128/sprite_get_height(sprTextbox);
	
	
	var _tb = instance_create_layer(_x,_y, "System", objTextbox);
	with _tb {
		
		image_xscale = _xScale;
		image_yscale = _yScale;
		
		textX = 16;
		textY = 16;
		textW = floor((bbox_right - bbox_left) - 32);	
		
		DialogueSet(_seq);
		
	}
	
	
	//setup global state machine
	global.gameState = GameStateDialogue;
	global.gameStateTarget = _stateTarget;
	
	//lock everybody in place
	with objPlayer {
		playerStatePrev = playerState;
		playerState = PlayerStateLocked;
	}
	with objEnemyParent {
		enemyStatePrev = enemyState;
		enemyState = EnemyStateLocked;
	}
	
}

//destroy all dialogue objects
function DialogueClean(){
	
	with objTextbox instance_destroy();
	with objTextboxFollower instance_destroy();
	
}