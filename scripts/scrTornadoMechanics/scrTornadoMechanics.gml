


function PlayerTornadoScan (_radius) {
	
	var _touched_table = collision_circle(x, y, _radius, objParentTable, false, true);

	if (_touched_table != noone && _touched_table.has_items) {
		
		show_debug_message("Touched table!");
		
		
	}



}













