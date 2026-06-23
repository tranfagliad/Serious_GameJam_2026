//sfx (general)
function SoundPlay(_snd, _volPercent = 100, _looping = false){
	
	//stop previous sound
	if audio_is_playing(_snd) audio_stop_sound(_snd);
	
	//limit volume percentage to 500%
	_volPercent = clamp(_volPercent, 0, 500);
	
	//change gain by percentage
	var _gain = (global.soundVolume * _volPercent) / 100;
	
	//play the sound
	var _id = audio_play_sound(_snd,1,_looping,_gain);
	return _id;

}