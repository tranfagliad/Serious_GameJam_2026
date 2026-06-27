function PauseUpdateVolumeSound(){
	
	global.soundVolume = butVolume;
	VolumeUpdateAmbient();
	
}

function PauseUpdateVolumeMusic(){
	
	global.musicVolume = butVolume;
	VolumeUpdateAmbient();
	
}

function PauseUpdateAmbientOffice(){
	
	global.ambientOfficeActive = !global.ambientOfficeActive;
	if !global.ambientOfficeActive AmbientFadeOut(AMBIENT_OFFICE, 0); //let the reverse trigger on unpause
	
}

function PauseUpdateAmbientTornado(_active){
	
	global.ambientTornadoActive = !global.ambientTornadoActive;
	if !global.ambientTornadoActive AmbientFadeOut(AMBIENT_PLAYER_TORNADO, 0); //let player code handle tornado
	
}

function PauseUpdateSfxText(){
	
	global.sfxTextActive = !global.sfxTextActive;
	
}

function PauseUpdateScreenShake(){
	
	global.screenShakeActive = !global.screenShakeActive;
	
}