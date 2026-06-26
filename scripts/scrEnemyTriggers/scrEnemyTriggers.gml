function EnemyDeath(){
	
	var _ghostId = instance_create_layer(x,y, "Enemy", objEnemyGhost);
	switch sprite_index {
		
		case sprEnemy1F: { SoundPlay(sfxEnemyDeathFemale, 90);	sprite_index = sprEnemy1FDeath;		_ghostId.sprite_index = sprEnemy1Ghost; } break;
		case sprEnemy2F: { SoundPlay(sfxEnemyDeathFemale, 90);	sprite_index = sprEnemy2FDeath;		_ghostId.sprite_index = sprEnemy2Ghost; } break;
		case sprEnemy3F: { SoundPlay(sfxEnemyDeathFemale, 90);	sprite_index = sprEnemy3FDeath;		_ghostId.sprite_index = sprEnemy3Ghost; } break;
		
		case sprEnemy1M: { SoundPlay(sfxEnemyDeathMale, 90);	sprite_index = sprEnemy1MDeath;		_ghostId.sprite_index = sprEnemy1Ghost; } break;
		case sprEnemy2M: { SoundPlay(sfxEnemyDeathMale, 90);	sprite_index = sprEnemy2MDeath;		_ghostId.sprite_index = sprEnemy2Ghost; } break;
		case sprEnemy3M: { SoundPlay(sfxEnemyDeathMale, 90);	sprite_index = sprEnemy3MDeath;		_ghostId.sprite_index = sprEnemy3Ghost; } break;
		
		case sprBoss:	SoundPlay(sfxEnemyBossDeath, 90); break;
		
	}
	
	image_index = 0;
	image_speed = 1;
	
	damageActive = false;
	explodeCd = 60;
	enemyState = EnemyStateExplode;
	
}

function EnemyHit(_damage){
	
	hp -= _damage;
	if hp <= 0 EnemyDeath();
	
	//make enemy flash and invul for short time
	invulCd = invulCdMax;
	image_blend = global.enemyHitColor;
	
}