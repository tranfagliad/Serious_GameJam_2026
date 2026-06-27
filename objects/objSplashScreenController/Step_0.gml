switch (mode) {
    
    case 0:
        timer++;
        fade_alpha = 1 - (timer / fade_duration);
        if (timer >= fade_duration) {
            timer = 0;
            fade_alpha = 0;
            mode = 1;
        }
        break;
        
    case 1:
        timer++;
        var _skip = objInputManager.pressed.space || objInputManager.pressed.enter;
        
        if (timer >= splash_duration || _skip) {
            timer = 0;
            mode = 2;
        }
        break;
        
    case 2:
		TransitionStart(rmMainMenu, sqFadeOut, sqFadeIn, 0,0, GameStatePaused);
        //timer++;
        //fade_alpha = (timer / fade_duration);
        //if (timer >= fade_duration) {
        //    fade_alpha = 1;
        //    mode = 3; // Trigger warp
        //}
        break;
        
    case 3:
       // global.gameState = GameStatePaused;
       // room_goto(rmMainMenu);
        break;
}
