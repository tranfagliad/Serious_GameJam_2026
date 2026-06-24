//chose a sprite out of 2
var _al = array_length(spriteChoice);
if _al > 0 {
	
	var _i = irandom(_al - 1);
	sprite_index = spriteChoice[_i];
	
} else instance_destroy();