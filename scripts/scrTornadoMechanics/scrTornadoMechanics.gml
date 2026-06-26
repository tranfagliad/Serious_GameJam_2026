
function PlayerTornadoItemPickup (_radius) {
	// Did the tornado touch a table?
	var _touched_table = collision_circle(x, y, _radius, objParentTable, false, true);

	if (_touched_table != noone && _touched_table.hasItems) {
		
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
				
				//create item objects
				repeat _item_amount {
					ItemObjectCreate(_item_type);
				}
				
				//play sfx
				switch _item_type {
					case "papers":		SoundPlay(sfxPaperPickup);		break;
					case "staplers":	SoundPlay(sfxStaplerPickup);	break;
					case "computers":	SoundPlay(sfxComputerPickup);	break;
				}
				
				
				// Clear the contents of the table
				variable_struct_set(_touched_table.contents, _item_type, 0);
			
				_took_items = true;
			}
			
			// Empty the table, start the timer for items to respawn
			if (_took_items) {
				_touched_table.hasItems = false;
				_touched_table.image_index = 1;
				_touched_table.itemRespawnTime = _touched_table.itemRespawnTimeMax;
				_touched_table.tableState = TableStateCooldown;
				//_touched_table.alarm[0] = _touched_table.itemRespawnTime;	//moved this to manual cooldown to be easier to pause
			}
		}	
	}
}



function DrawTornadoVisuals () {

    if (isSpinning && spinSpeed >= tornadoThreshold) {

        draw_sprite_ext(sprTornado, image_index, x, y, 1, 1, image_angle, c_white, 1);
    	
		//ONLY DRAWING PAPER THIS WAY I THINK
		
        //var _categories = struct_get_names(global.inventoryVisuals);
        
        //for (var _i = 0; _i < array_length(_categories); _i++) {
            var _category = "papers";//_categories[_i];
            var _visual_array = struct_get(global.inventoryVisuals, _category);
            
            var _sprite = noone;
            if (_category == "papers") _sprite = sprPaper;
            //if (_category == "computers") _sprite = sprPlaceholderComputer;
            //if (_category == "staplers") _sprite = sprPlaceholderStapler;
            
           // if (_sprite == noone) continue;
            
            // Render every item caught in this category's vortex loop
            for (var _j = 0; _j < array_length(_visual_array); _j++) {
                var _item = _visual_array[_j];
                
                var _draw_x = x + lengthdir_x(_item.orbit_distance, _item.orbit_angle);
                var _draw_y = y + lengthdir_y(_item.orbit_distance, _item.orbit_angle);
                
                draw_sprite_ext(_sprite, 0, _draw_x, _draw_y, 1, 1, _item.item_rotation, c_white, 1);
            }
        //}
    }
}


/* idk don't like this I think
function PlayerTornadoEnemyCollision (_radius) {
	
	//create a list of collisions
	var _colList = ds_list_create();
	
	//collision check
	var _colNum = collision_circle_list(x, y, _radius, objEnemyParent, false, true, _colList, true);
	if (_colNum > 0) {
		
		//iterate through each enemy within tornado
		for (var _i = 0; _i < _colNum; _i++) {
			
			//get enemy id
			var _enId = _colList[| _i];
			
			//do not damage deactivated enemies
			if !_enId.damageActive continue;
			
			//iterate through each item category
			var _categories = struct_get_names(global.inventory);
			for (var _j = 0; _j < array_length(_categories); _j++) {
				
				//check item amount
				var _category = _categories[_j];
				var _itemAmount = struct_get(global.inventory, _category);
				if (_itemAmount > 0) {
					
					//update inventory
					struct_set(global.inventory, _category, _itemAmount - 1);
					
					//damage enemy
					with _enId EnemyHit(other.playerDamage);
				
					//refresh tornado cd
					tornadoColCd = tornadoColCdMax;
					
					//stop item reduction
					exit;
					
				} else continue;
				
			}
			
		}
		
	}
	
	//destroy the list
	ds_list_destroy(_colList);
	
}
*/