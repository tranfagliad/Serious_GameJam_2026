function EnemyDeath(){
	
	//play sfx
	switch sprite_index {
		
		case sprEnemy1F: SoundPlay(sfxEnemyDeathFemale, 90); break;
		case sprEnemy2F: SoundPlay(sfxEnemyDeathFemale, 90); break;
		case sprEnemy3F: SoundPlay(sfxEnemyDeathFemale, 90); break;
		
		case sprEnemy1M: SoundPlay(sfxEnemyDeathMale, 90); break;
		case sprEnemy2M: SoundPlay(sfxEnemyDeathMale, 90); break;
		case sprEnemy3M: SoundPlay(sfxEnemyDeathMale, 90); break;
		
		case sprBoss:	SoundPlay(sfxEnemyBossDeath, 90); break;
		
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