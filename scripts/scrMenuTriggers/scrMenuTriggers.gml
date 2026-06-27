function VolumeUpdateSound(_vol){
	
	global.soundVolume = _vol;
	VolumeUpdateAmbient();
	
}

function VolumeUpdateMusic(_vol){
	
	global.musicVolume = _vol;
	VolumeUpdateAmbient();
	
}

function AmbientStateUpdateOffice(){
	
	global.ambientOfficeActive = !global.ambientOfficeActive;
	
}

function AmbientStateUpdateTornado(_active){
	
	global.ambientTornadoActive = !global.ambientTornadoActive;
	
}

function SfxStateUpdateText(){
	
	global.sfxTextActive = !global.sfxTextActive;
	
}