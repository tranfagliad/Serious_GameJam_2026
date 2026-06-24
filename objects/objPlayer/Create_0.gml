
image_speed = 0;
image_index = 0;


//general
playerState = PlayerStateDefault;
playerStatePrev = PlayerStateDefault;
playerSpeed = 4;
playerSpeedDefault = 4;
playerSpeedSlowed = 2;
playerDamage = 1;


//health
maxHp = 5;
currentHp = 5;
invulCd = 0;
invulCdMax = 180;


// Spin and tornado variables
spinSpeed = 0;
maxSpinSpeed = 50;
spinAccel = 0.2; //0.05
spinDecel = 0.3;
tornadoThreshold = 40;
isSpinning = false;

//tornado collision cooldown
tornadoColCd = 0;
tornadoColCdMax = 15;


// Dash variables
dashDuration = 10;
dashTimer = 0;
dashSpeed = 20;
dashDirection = 0;
dashCd = 0;
dashCdMax = 60;


//update w/e vars are needed
PlayerStatsLoadUp();