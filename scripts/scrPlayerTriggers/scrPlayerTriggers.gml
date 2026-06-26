function PlayerPaperShielded(_paperAmount){
	
	//reduce paper amount
	_paperAmount = Approach(_paperAmount, 0, global.paperReductionAmount);
	global.inventory.papers = _paperAmount;
				
	//flash to indicate invulnerability
	invulCd = invulCdMax/2;
	image_blend = global.playerFlashColor;
	
}

function PlayerHit(_damage){
	
	// hp reduction
	currentHp -= _damage;
	
	// Player Death Animation
	if (currentHp <= 0) {
		
		explodeCd = 30;
		sprite_index = sprPlaceholderExplosion;
		playerStatePrev = playerState;
		playerState = PlayerStateExplode;
		
	}
	
	//invulnerability
	invulCd = invulCdMax;
	image_blend = global.playerHitColor;
	
	//screen shake
	ScreenShakeStart(60, 6);
}


function PlayerCollisionEnemy(){
	
	var _enCol = instance_place(x, y, objEnemyParent);
	if instance_exists(_enCol) && invulCd <= 0 {
		
		//check if enemy is active
		if _enCol.damageActive {
			
			//check paper
			var _paperAmount = global.inventory.papers;
			if (_paperAmount > 0) {
				
				//shield
				PlayerPaperShielded(_paperAmount);
				
				//unique paper sfx
				
			} else {
				
				//player hit
				PlayerHit(_enCol.damage);
				
				//player hit sfx
			}
			
			//enemy also takes a hit
			with _enCol if (invulCd <= 0) EnemyHit(other.playerDamage);
			
		}
		
	}
	
}


function PlayerDeath () {

	currentHp = 0;   // Prevent HP from becoming negative
		
	with (objGameController) {
		wheelPhase = 0;
		wheelAngle = irandom(359);
		wheelSpeed = 0;
	}
	with (objPlayer) {
		playerStatePrev = playerState;
		playerState = PlayerStateLocked;
		image_speed = 0;
	}
	with (objEnemyParent) {
		enemyStatePrev = enemyState;
		enemyState = EnemyStateLocked;
		image_speed = 0;
	}
		
	// Empty Inventory on death (?)
	global.inventory = {
		papers: 0,
		computers: 0,
		staplers: 0
	};
	global.inventoryVisuals = {
		papers: [],
		computers: [],
		staplers: []
	};
		
	global.gameState = GameStatePlayerDeath;
}




function PlayerStatsSaveUp(){
	with objPlayer {
		
		//save stats between transitions
		global.playerHp = currentHp;
		global.playerSpeed = playerSpeedDefault;
		global.playerDashPower = dashPower;
		
	}
}




function PlayerStatsLoadUp(){
	with objPlayer {
		
		//load stats between transitions
		currentHp = global.playerHp;
		playerSpeedDefault = global.playerSpeed;
		dashPower = global.playerDashPower;
		
	}
}

function PlayerStatsReset(){
	
	//reset every global
	global.playerHp = 3;
	global.playerMaxHp = 3;
	global.playerSpeed = 4;
	global.playerDashPower = 1;
	
}