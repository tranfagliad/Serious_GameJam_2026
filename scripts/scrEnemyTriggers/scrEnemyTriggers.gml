function EnemyDeath(){
	
	damageActive = false;
	explodeCd = 60;
	sprite_index = sprPlaceholderExplosion;
	enemyState = EnemyStateExplode;
	
	//check for boss
	if object_index == objEnemyBoss DialogueStart(DLG_SEQ_OUTRO, GameStateCredits);
	
}

function EnemyHit(_damage){
	
	hp -= _damage;
	if hp <= 0 EnemyDeath();
	
	invulCd = invulCdMax;
	
}