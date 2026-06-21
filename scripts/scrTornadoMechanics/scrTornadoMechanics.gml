
function PlayerTornadoItemPickup (_radius) {
	// Did the tornado touch a table?
	var _touched_table = collision_circle(x, y, _radius, objParentTable, false, true);

	if (_touched_table != noone && _touched_table.has_items) {
		
		var _item_types = variable_struct_get_names(_touched_table.contents);
        var _type_count = array_length(_item_types);
        var _took_items = false;
		
		// Go through each item type and add items to the player inventory
		for (var _i = 0; _i < _type_count; _i++) {
			var _item_type = _item_types[_i];
			var _item_amount = variable_struct_get(_touched_table.contents, _item_type);
			
			if (_item_amount > 0) {
				var _current_inventory_amount = variable_struct_get(global.inventory, _item_type);
			
				// Add the contents of the table to the player
				variable_struct_set(global.inventory, _item_type, _current_inventory_amount + _item_amount);
			
				// Clear the contents of the table
				variable_struct_set(_touched_table.contents, _item_type, 0);
			
				_took_items = true;
			}
			
			// Empty the table
			if (_took_items) {
				_touched_table.has_items = false;
				_touched_table.image_index = 1;
			}
		}	
	}
}





