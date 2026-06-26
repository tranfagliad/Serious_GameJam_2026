
image_speed = 0;
image_index = 0;   // 0 = Full, 1 = Empty

tableState = TableStateDefault;
hasItems = true;
itemRespawnTime = -1;
itemRespawnTimeMax = 20 * game_get_speed(gamespeed_fps);   // 20 second item respawn


defaultContents = {
	papers: 4,
	computers: 1,
	staplers: 10

}

contents = variable_clone(defaultContents);
