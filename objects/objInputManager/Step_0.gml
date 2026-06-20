
// Reset input states every frame
for (var _key = 0; _key < array_length(input_keys); _key++)
{
	var _key_name = input_keys[_key];
	pressed[$ _key_name]  = false;
	held[$ _key_name]     = false;
	released[$ _key_name] = false;
}



// Keyboard Input Checks
for (var _key = 0; _key < array_length(input_keys); _key++)
{
	var _key_name = input_keys[_key];
	var _keybinds = input[$ _key_name];
	for (var _keybind = 0; _keybind < array_length(_keybinds); _keybind++)
	{
		var _bind = _keybinds[_keybind];
		if (keyboard_check(_bind))          { held[$ _key_name] = true; }
		if (keyboard_check_pressed(_bind))  { pressed[$ _key_name] = true; }
		if (keyboard_check_released(_bind)) { released[$ _key_name] = true; }
	}
}
