function PlayerHit(_damage){
	
	//hp reduction
	currentHp -= _damage;
	if currentHp <= 0 GameLose();
	
	//invulnerability
	invulCd = invulCdMax;
	image_blend = c_red;
	
	//screen shake
	ScreenShakeStart(60, 6);
	
}