var _boss = instance_create_layer(x,y, "Enemy", objEnemyBoss);
with _boss {
	enemyStatePrev = enemyState;
	enemyState = EnemyStateLocked;
}

instance_destroy();