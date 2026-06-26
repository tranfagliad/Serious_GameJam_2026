// Inherit the parent event
event_inherited();

//become below normal enemies
depth += 1;

//do not spin during cutscene
image_blend = c_white;
image_index = 0;
image_speed = 0;

//make itself bigger
image_xscale = 2;
image_yscale = 2;