
image_speed = 0;
image_index = 0;   // 0 = Full, 1 = Empty

hasItems = true;
itemRespawnTime = 10 * game_get_speed(gamespeed_fps);   // 10 second item respawn


defaultContents = {
	papers: 4,
	computers: 1,
	staplers: 10

}

contents = variable_clone(defaultContents);
