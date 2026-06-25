if global.gameState == GameStateDefault {
	DrawInventory(global.inventory);
	DrawPlayerHealth(currentHp, maxHp);
	DrawPlayerSpinMeter(spinSpeed, maxSpinSpeed, dashCd, dashCdMax);
	DrawEnemyDefeatReq(global.enemyDefeated, global.enemyDefeatedReqCurrent);
}