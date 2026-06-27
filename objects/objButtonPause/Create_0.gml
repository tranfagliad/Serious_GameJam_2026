image_speed = 0;
image_index = 0;

//change name based on script
switch butScript {
	
	case PauseUpdateSfxText:			butName = "DIALOGUE SOUND";					break;
	case PauseUpdateScreenShake:		butName = "SCREEN SHAKE";					break;
	case PauseUpdateAmbientOffice:		butName = "OFFICE AMBIENT SOUND EFFECT";	break;
	case PauseUpdateAmbientTornado:		butName = "TORNADO SOUND EFFECT";			break;
	
	case PauseUpdateVolumeMusic:		butName = "MUSIC";			break;
	case PauseUpdateVolumeSound:		butName = "SOUND";			break;

}