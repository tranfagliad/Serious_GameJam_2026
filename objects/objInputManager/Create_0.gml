/**
 * README: To detect inputs, use the input map. They are all booleans.
 * 
 * EX:
 *     objInputManager.pressed.up
 *     objInputManager.held.up
 */

input = {
	up:    [ W_KEY ],
	down:  [ S_KEY ],
	left:  [ A_KEY ],
	right: [ D_KEY ],
	
	space:  [ vk_space ],
	escape: [ vk_escape ],
	
	start: [ vk_enter ],
};
input_keys = variable_struct_get_names(input);



// Input States (Updated every frame)
pressed  = {};
held     = {};
released = {};

for (var _key = 0; _key < array_length(input_keys); _key++)
{
    var _name = input_keys[_key];
    pressed[$ _name]  = false;
    held[$ _name]     = false;
    released[$ _name] = false;
}
