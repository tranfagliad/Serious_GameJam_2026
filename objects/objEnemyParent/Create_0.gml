//chose a sprite out of 2
var _al = array_length(spriteChoice);
if _al > 0 {
	
	//choose a sprite
	var _i = irandom(_al - 1);
	sprite_index = spriteChoice[_i];
	
	//show that enemy is untargetable during spawn
	image_blend = c_gray;
	
} else instance_destroy();