function TableStateDefault(){
	
	//just chill
	
}

function TableStateCooldown(){
	
	itemRespawnTime = Approach(itemRespawnTime, 0, 1);
	if itemRespawnTime <= 0 {
		
		//reset table contents
		contents = variable_clone(defaultContents);
		hasItems = true;
		image_index = 0;
		
		tableState = TableStateDefault;
		
	}
	
}