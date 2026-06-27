var _x = device_mouse_x_to_gui(0);
var _y = device_mouse_y_to_gui(0);

if (position_meeting(_x, _y, id)) {
    image_index = 1;
    
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
	if (_dialogue || _shake || _office || _tornado) image_index = 0; else image_index = 1;
	
}