//draw self
draw_self();

//get text parameters
var _sprite = sprPortraits;
var _imInd = portraitNum;

//possible scaling
var _scale = 2;

//draw the sprite
draw_sprite_ext(_sprite, _imInd, x,y, _scale,_scale, 0,c_white, image_alpha);

//draw the border
draw_sprite_ext(sprite_index, 1, x,y, image_xscale,image_yscale, 0,c_white, image_alpha);