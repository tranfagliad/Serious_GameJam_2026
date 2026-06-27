// Configuration
splash_duration = 4 * game_get_speed(gamespeed_fps); // 5 seconds of screen time
fade_duration   = 1.2 * game_get_speed(gamespeed_fps); // 1.5 second fade duration

// Timing Trackers
timer = 0;
fade_alpha = 0;

// States: 0 = Fading In, 1 = Displaying, 2 = Fading Out, 3 = Trigger Room Jump
mode = 0;
