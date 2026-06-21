
//moved player behavior into state machine
if !global.gamePaused && !global.unpausingInputLock {
	playerState();
}