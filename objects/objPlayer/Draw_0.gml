draw_self();

//setup font and alignment
draw_set_font(fntConsol);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//debug ui
if global.showDebugUI {
	
	draw_text(x,	y+15*0,	$"spinning: {isSpinning}");
	draw_text(x,	y+15*1,	$"spin speed: {spinSpeed}");
	draw_text(x,	y+15*2,	$"damage: {playerDamage}");
	draw_text(x,	y+15*3,	$"hp: {global.playerHp}");
	draw_text(x,	y+15*4,	$"invul cd: {invulCd}");
	draw_text(x,	y+15*5,	$"move speed: {global.playerSpeed}");
	draw_text(x,	y+15*6,	$"dash power: {global.playerDashPower}");
}

DrawTornadoVisuals();
