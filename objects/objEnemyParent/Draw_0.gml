
draw_self();

//debug ui
if global.showDebugUI {
	
	draw_text(x,	y+15*0,	$"state: {script_get_name(enemyState)}");
	draw_text(x,	y+15*1,	$"hp: {hp}");
	draw_text(x,	y+15*2,	$"damage: {damage}");
	draw_text(x,	y+15*3,	$"damage active: {damageActive}");
	draw_text(x,	y+15*4,	$"wait cd: {waitCd}");
	
}