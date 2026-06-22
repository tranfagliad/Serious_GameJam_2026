function EnemyDeath(){
	
	damageActive = false;
	explodeCd = 60;
	enemyState = EnemyStateExplode;
	sprite_index = sprPlaceholderExplosion;
	
}

function EnemyHit(_damage){
	
	hp -= _damage;
	if hp <= 0 EnemyDeath();
	
}