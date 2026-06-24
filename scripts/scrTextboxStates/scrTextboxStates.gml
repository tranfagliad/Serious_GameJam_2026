function TextboxStateAppear(){
	
	image_alpha = Approach(image_alpha, 1, alphaSpeed);
	if image_alpha >= 1 textboxState = TextboxStateDialogue;
	
}

function TextboxStateDialogue(){
	
	//progress text
	textProgress = Approach(textProgress, textLength, textSpeed);
	
	//dialogue sfx
	if audio_exists(textSfx) && !audio_is_playing(textSfx) && (textProgress < textLength) {
		SoundPlay(textSfx);
	}
	
	//check player input
	if (objInputManager.pressed.space || objInputManager.pressed.enter) {
	
		//check text progress
		if (textProgress >= textLength) {
		
			//reset progress
			textProgress = 1;
		
			//progress dialogue
			DialogueProgress();
					
		} else {
		
			//warp progress (not on first frame)
			if (textProgress > 2) textProgress = textLength;
					
		}
				
	}
	
}

function TextboxStateDissappear(){
	
	image_alpha = Approach(image_alpha, 0, alphaSpeed);
	if image_alpha <= 0 {
			
		//move from dialogue
		global.gameState = global.gameStateTarget;
		
		//unlock other state machines
		with objPlayer playerState = playerStatePrev;
		with objEnemyParent enemyState = enemyStatePrev;
		
		//clean dialogue
		DialogueClean();
				
	}
	
}