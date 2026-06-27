var _x = device_mouse_x_to_gui(0);
var _y = device_mouse_y_to_gui(0);

//highlight when hovering, choose correct sprite when not hovering depending on button state
if (position_meeting(_x, _y, id)) {
	
	//set highlight
    image_index = 1;
    
	//activate script
    if (mouse_check_button_pressed(mb_left)) {
		SoundPlay(sfxUIClick, 50);
		if script_exists(butScript) butScript();
    }
	
} else {
    
	//disable toggle
	var _dialogue	= (butScript == PauseUpdateSfxText			&& global.sfxTextActive);
	var _shake		= (butScript == PauseUpdateScreenShake		&& global.screenShakeActive);
	var _office		= (butScript == PauseUpdateAmbientOffice	&& global.ambientOfficeActive);
	var _tornado	= (butScript == PauseUpdateAmbientTornado	&& global.ambientTornadoActive);
	if (_dialogue || _shake || _office || _tornado) image_index = 0; else image_index = 2;
	
	//check against sound or music volume
	var _checkVar = noone;
	if (butScript == PauseUpdateVolumeMusic) _checkVar = global.musicVolume;
	if (butScript == PauseUpdateVolumeSound) _checkVar = global.soundVolume;
	if is_real(_checkVar) && (_checkVar >= butVolume) image_index = 3;
	
}