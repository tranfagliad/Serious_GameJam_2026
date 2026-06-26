function EnemyDeath(){
	
	//play sfx
	switch sprite_index {
		
		case sprEnemy1F: SoundPlay(sfxEnemyDeathFemale); break;
		case sprEnemy2F: SoundPlay(sfxEnemyDeathFemale); break;
		case sprEnemy3F: SoundPlay(sfxEnemyDeathFemale); break;
		
		case sprEnemy1M: SoundPlay(sfxEnemyDeathMale); break;
		case sprEnemy2M: SoundPlay(sfxEnemyDeathMale); break;
		case sprEnemy3M: SoundPlay(sfxEnemyDeathMale); break;
		
		case sprBoss:	SoundPlay(sfxEnemyBossDeath); break;
		
	}
	
	damageActive = false;
	explodeCd = 60;
	sprite_index = sprPlaceholderExplosion;
	enemyState = EnemyStateExplode;
	
}

function EnemyHit(_damage){
	
	hp -= _damage;
	if hp <= 0 EnemyDeath();
	
	//make enemy flash and invul for short time
	invulCd = invulCdMax;
	image_blend = global.enemyHitColor;
	
}