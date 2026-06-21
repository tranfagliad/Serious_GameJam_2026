
image_speed = 0;
image_index = 0;   // 0 = Full, 1 = Empty

hasItems = true;
itemRespawnTime = 10 * game_get_speed(gamespeed_fps);   // 20 second item respawn


defaultContents = {
	papers: 4,
	computers: 1,
	staples: 10

}

contents = {
	papers: defaultContents.papers,
	computers: defaultContents.computers,
	staples: defaultContents.staples
}
