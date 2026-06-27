if global.gameState == GameStateDefault {
	DrawInventory(global.inventory);
	DrawPlayerHealth();
	DrawPlayerSpinMeter(spinSpeed, maxSpinSpeed, dashCd, dashCdMax);
	if (room == rmBossLevel) {
		DrawBossHealthBar();
	} else {
		DrawEnemyDefeatReq(global.enemyDefeated, global.enemyDefeatedReqCurrent);
	}
}