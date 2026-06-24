
draw_self();

//setup font and alignment
draw_set_font(fntConsol);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

//debug ui
if global.showDebugUI {
	
	draw_text(x,	y+15*0,	$"state: {script_get_name(tableState)}");
	draw_text(x,	y+15*1,	$"has items: {hasItems}");
	draw_text(x,	y+15*2,	$"respawn time: {itemRespawnTime}");
	draw_text(x,	y+15*3,	$"P: {contents.papers}, C: {contents.computers}, S: {contents.staplers}");
	
}