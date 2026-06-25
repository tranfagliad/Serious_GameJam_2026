if !global.gamePaused && !global.midTransition {
	
	//cooldown until expiring
	explodeCd = Approach(explodeCd, 0, 1);
	if explodeCd <= 0 instance_destroy();
	
	#region deal damage upon impact

		//create a list of collisions
		var _colList = ds_list_create();
	
		//get a list of enemies within range
		var _colNum = instance_place_list(x, y, objEnemyParent, _colList, true);
		if (_colNum > 0) {
		
			//iterate through each enemy
			for (var _i = 0; _i < _colNum; _i++) {
			
				//damage enemy
				var _enId = _colList[| _i];
				with _enId if (damageActive && invulCd <= 0) EnemyHit(damage);
			
			}
		}

		//destroy the list
		ds_list_destroy(_colList);

	#endregion
	
}