#region simple sfx

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

	//stop sounds on the spot for any reason
	function SoundStop(_snd){
	
		//stop sound
		if audio_is_playing(_snd) audio_stop_sound(_snd);
	
	}

#endregion

#region looping ambient control
	
	//setup ambient data
	function AmbientDataSetup(){
		
		return {ambientId: noone, ambientIdFade: noone, ambientTrack: noone, ambientVol: 100};
		
	}
	
	//fade out a track
	function AmbientFadeOut(_type, _time = 1000){
		
		//get sound id
		var _data = global.ambient[$ _type] ?? AmbientDataSetup();
		var _snd = _data.ambientId;
		var _sndFade = _data.ambientIdFade;
		
		//reset currently fading track
		SoundStop(_sndFade);
		_data.ambientIdFade = noone;
		
		//check if track is playing
		if audio_is_playing(_snd) {
			
			//fade out
			audio_sound_gain(_snd, 0, _time);
			
			//make game manager stop the track after it fades
			_data.ambientIdFade = _snd;
			
		}
		
		//reset data
		_data.ambientId = noone;
		_data.ambientTrack = noone;
		_data.ambientVol = 100;
		
	}
	
	//fade out every ambient track
	function AmbientFadeOutAll(){
		
		//iterate through every ambient type currently being used
		var _types = struct_get_names(global.ambient);
		var _al = array_length(_types);
		for (var i = 0; i < _al; i++) {
			
			AmbientFadeOut(_types[i]);
			
		}
		
	}
	

	//play a new track
	function AmbientPlay(_type, _snd, _volPercent = 100, _looping = true, _fadeInTime = 2500){
		
		//get ambient struct or setup a new one
		if !struct_exists(global.ambient, _type) global.ambient[$ _type] = AmbientDataSetup();
		var _data = global.ambient[$ _type];
		
		
		//stop the same track from playing by accident
		SoundStop(_snd);
	
		//limit volume percentage to 500%
		_volPercent = clamp(_volPercent, 0, 500);
		
		
		//switch which global volume type is applied
		var _volGlobal = global.soundVolume;
		switch _type {
			
			case AMBIENT_MUSIC: _volGlobal = global.musicVolume; break;
			
		}
	
		//change gain by percentage
		var _gain = (_volGlobal * _volPercent) / 100;
	
		//play the sound
		var _id = audio_play_sound(_snd, 1, _looping, 0);
		audio_sound_gain(_id, _gain, _fadeInTime);
		
		
		//update music variables
		_data.ambientId = _id;
		_data.ambientTrack = _snd;
		_data.ambientVol = _volPercent;
		
		//return sound id
		return _id;
	
	}

	//change music to new track or empty
	function AmbientChange(_type, _nextTrack = noone, _volPercent = 100, _looping = true, _fadeInTime = 2500, _fadeOutTime = 1000){
		
		//get ambient struct or setup a new one
		if !struct_exists(global.ambient, _type) global.ambient[$ _type] = {ambientId: noone, ambientTrack: noone, ambientIdFade: noone, ambientVol: 100};
		var _data = global.ambient[$ _type];
		
		
		//check if this track is being played already
		if (_data.ambientTrack != _nextTrack) || (!audio_is_playing(_data.ambientId)) {
		
			//fade out last track
			AmbientFadeOut(_type, _fadeOutTime);
	
			//check if track should be empty
			if audio_exists(_nextTrack) {
		
				AmbientPlay(_type, _nextTrack, _volPercent, _looping, _fadeInTime);
		
			} else {
		
				//empty stored data
				_data.ambientTrack = noone;
				_data.ambientId = noone;
				_data.ambientVol = 100;
		
			}
	
		} else {
			
			//switch type of volume depending on ambient type
			var _volGlobal = global.soundVolume;
			switch _type {
			
				case AMBIENT_MUSIC: _volGlobal = global.musicVolume; break;
			
			}
			
			//get current gain and new gain
			var _gain = audio_sound_get_gain(_data.ambientId);
			var _gainNew = (_volGlobal * _volPercent) / 100;
				
			//change gain if they are unequal (do this so it would change if global volume changes as well as in-code vol percent changes)
			if (_gain != _gainNew) {
				audio_sound_gain(_data.ambientId, _gainNew, _fadeInTime);
				_data.ambientVol = _volPercent;
			}
		
		}
	
	}
	
	//check for fading every step
	function AmbientFadeCheck(){
		
		//iterate through all ambient
		var _names = struct_get_names(global.ambient);
		var _al = array_length(_names);
		for (var i = 0; i < _al; i++) {
			
			//get id of sound set to fade out
			var _name = _names[i];
			var _fadeId = global.ambient[$ _name].ambientIdFade;
			
			//check if it is playing
			if audio_is_playing(_fadeId) {
			
				//check gain
				var _gain = audio_sound_get_gain(_fadeId);
				if (_gain <= 0) {
		
					//stop music
					SoundStop(_fadeId);
					global.ambient[$ _name].ambientIdFade = noone;
		
				}
	
			}
			
		}
		
	}
	
#endregion