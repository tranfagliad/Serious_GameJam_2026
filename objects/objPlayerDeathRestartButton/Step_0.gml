if (is_fading) {
    fade_timer++;
    fade_alpha = (fade_timer / fade_duration);
    
    if (fade_timer >= fade_duration) {
        fade_alpha = 1;
		room_goto(rmLevelOne);
    }
    exit;
}


if (position_meeting(mouse_x, mouse_y, id)) {
    image_index = 1;
    
    if (mouse_check_button_pressed(mb_left)) {
        is_fading = true;
    }
} else {
    image_index = 0;
}
