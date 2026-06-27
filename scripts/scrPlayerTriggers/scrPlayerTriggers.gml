function PlayerPaperShielded(_paperAmount){
	
	//reduce paper amount
	_paperAmount = Approach(_paperAmount, 0, global.paperReductionAmount);
	global.inventory.papers = _paperAmount;
				
	//flash to indicate invulnerability
	invulCd = invulCdMax/2;
	image_blend = global.playerFlashColor;
	
	//unique paper sfx
	SoundPlay(sfxPaperHit);
	
}

function PlayerHit(_damage){
	
	// hp reduction
	global.playerHp -= _damage;
	
	// Player Death Animation
	if (global.playerHp <= 0) {
		
		explodeCd = 60;
		sprite_index = sprPlayerDeath;
		playerStatePrev = playerState;
		playerState = PlayerStateExplode;
		
		//player death sfx
		SoundPlay(sfxPlayerDeath);
		
		//fade out player related sounds
		AmbientChange(AMBIENT_MUSIC, bgmWheel, 60);
		AmbientFadeOut(AMBIENT_OFFICE);
		PlayerSoundFadeOut();
		
	} else {
		
		//player hit sfx
		SoundPlay(sfxPlayerHit);
		
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
				
			} else {
				
				//player hit
				PlayerHit(_enCol.damage);
				
			}
			
			//enemy also takes a hit
			with _enCol if (invulCd <= 0) EnemyHit(other.playerDamage);
			
		}
		
	}
	
}


function PlayerDeath () {

	global.playerHp = 0;   // Prevent HP from becoming negative
		
	with (objGameController) {
		wheelPhase = 0;
		wheelAngle = irandom(359);
		wheelSpeed = 0;
		wheelScale = 0;
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
		//global.playerHp = currentHp;
		//global.playerSpeed = playerSpeedDefault;
		//global.playerDashPower = dashPower;
		
	}
}




function PlayerStatsLoadUp(){
	with objPlayer {
		
		//load stats between transitions
		//currentHp = global.playerHp;
		playerSpeedDefault = global.playerSpeed;
		//dashPower = global.playerDashPower;
		
	}
}

function PlayerStatsReset(){
	
	//reset every global
	global.playerHp = 3;
	global.playerMaxHp = 3;
	global.playerSpeed = 4;
	global.playerDashPower = 1;
	
}