//deletes the transition layer and any sequences within
function TransitionDeleteLayer(){
	
	if layer_exists("Transition") layer_destroy("Transition");
	
}

//places sequence in the room
function TransitionPlaceSequence(_type){
	
	//delete the transition layer and recreate it
	TransitionDeleteLayer();
	var _lay = layer_create(TRANS_DEPTH,"Transition");
	
	//check if sequence exists
	if sequence_exists(_type) {
		
		//let camera object handle sequence placement coordninates
		var _x = 0;
		var _y = 0;
		
		//create the sequence w/o saving its id
		layer_sequence_create(_lay,_x,_y,_type);
		
	} else show_debug_message("NO SEQUENCE DETECTED BRUH");
	
}

//called whenever you want to transition between rooms using sequences
function TransitionStart(_targetRoom, _typeOut, _typeIn, _playerX, _playerY, _stateTarget){
	
	if !global.gamePaused && !global.midTransition {
		
		global.midTransition = true;
		global.trTargetRoom = _targetRoom;
		
		//create the out sequence
		TransitionPlaceSequence(_typeOut);
		
		//save the in sequence to be created on room start by game manager
		//global.trSqInType = _typeIn;
		
		//creating sequence in another room (does not work in pure html export, for that you need to place this on room-start event within game controller or camera object)
		layer_set_target_room(_targetRoom);
		TransitionPlaceSequence(_typeIn);
		layer_reset_target_room();
		
		
		//set player position
		global.trPlayerX = _playerX;
		global.trPlayerY = _playerY;
		
		//update checkpoint
		global.playerPosCheckpoint = [_playerX, _playerY];
		
		
		//set state
		global.gameStateTarget = _stateTarget;
		global.gameState = GameStateTransition;
		
		//return result
		return true;
		
	} else return false;
	
}

//called as a moment at the end of an "Out" transition sequence
//and when teleporting between rooms w/o a sequence
function TransitionChangeRoom(){
	
	//go to the target room
	room_goto(global.trTargetRoom);
	
}

//called as a moment at the end of an "In" transition sequence
function TransitionFinished(){
	
	// self.elementId used to be bugged in the past but seems to be fixed now
	layer_sequence_destroy(self.elementID);
	global.midTransition = false;
	
}



//sharp transition w/e "in" transition sequence
function TransitionAbrupt(_targetRoom, _targetX, _targetY){
	
	//set the target room
	global.trTargetRoom = _targetRoom;
			
	//delete transition layers so their sequences won't appear accidentally
	TransitionDeleteLayer();
	layer_set_target_room(global.trTargetRoom);
	TransitionDeleteLayer();
	layer_reset_target_room();
		
	//change the room
	TransitionChangeRoom();
	
}