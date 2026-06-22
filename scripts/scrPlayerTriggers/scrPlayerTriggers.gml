function PlayerHit(_damage){
	
	currentHp -= _damage;
	if currentHp <= 0 GameLose();
			
	invulCd = invulCdMax;
	image_blend = c_red;
	
}