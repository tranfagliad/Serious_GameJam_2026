if global.gameState == GameStateDefault {
	DrawInventory(global.inventory);
	DrawPlayerHealth();
	DrawPlayerSpinMeter(spinSpeed, maxSpinSpeed, dashCd, dashCdMax);
	DrawEnemyDefeatReq(global.enemyDefeated, global.enemyDefeatedReqCurrent);
}