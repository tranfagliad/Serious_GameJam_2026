#region cheats
	
	//input cheatcode
	if (keyboard_lastchar == "b") keyboard_string = keyboard_lastchar;
	if (keyboard_string == global.cheatcode) {
		global.cheat = !global.cheat;
		keyboard_string = "";
	}
	
	//cheat commands
	if global.cheat {
		
		if keyboard_check_pressed(ord("R")) game_restart();
		if keyboard_check_pressed(vk_tab) global.showDebugUI = !global.showDebugUI;
		
		if keyboard_check_pressed(vk_f1) VolumeUpdateMusic(global.musicVolume - 0.1);
		if keyboard_check_pressed(vk_f2) VolumeUpdateMusic(global.musicVolume + 0.1);
		if keyboard_check_pressed(vk_f3) VolumeUpdateSound(global.soundVolume - 0.1);
		if keyboard_check_pressed(vk_f4) VolumeUpdateSound(global.soundVolume + 0.1);
		
		if keyboard_check_pressed(vk_f5) TransitionStart(rmLevelOne,	sqFadeOut, sqFadeIn, global.playerPosLevel1[0],		global.playerPosLevel1[1],		GameStateDefault);
		if keyboard_check_pressed(vk_f6) TransitionStart(rmLevelTwo,	sqFadeOut, sqFadeIn, global.playerPosLevel2[0],		global.playerPosLevel2[1],		GameStateDefault);
		if keyboard_check_pressed(vk_f7) TransitionStart(rmLevelThree,	sqFadeOut, sqFadeIn, global.playerPosLevel3[0],		global.playerPosLevel3[1],		GameStateDefault);
		if keyboard_check_pressed(vk_f8) TransitionStart(rmBossLevel,	sqFadeOut, sqFadeIn, global.playerPosBossLevel[0],	global.playerPosBossLevel[1],	GameStateDefault);
		
		if keyboard_check_pressed(ord("O")) global.playerHp = global.playerMaxHp;
		if keyboard_check_pressed(ord("P")) global.playerHp = 0;
		if keyboard_check_pressed(ord("N")) with objPlayer invulCd = invulCdMax;
		if keyboard_check_pressed(ord("M")) global.enemyDefeated = global.enemyDefeatedReqCurrent;
		
	}

#endregion

//global state machine
global.gameState();

//ambient fade control
AmbientFadeCheck();

//fullscreen
if !global.htmlActive {
	if objInputManager.pressed.fullscreen window_set_fullscreen(!window_get_fullscreen());
}