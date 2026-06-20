// Detect Inputs
var _input_x = objInputManager.held.right - objInputManager.held.left;
var _input_y = objInputManager.held.down - objInputManager.held.up;


if (_input_x != 0 || _input_y != 0) {

    var _direction = point_direction(0, 0, _input_x, _input_y);
    
    var _move_x = lengthdir_x(playerSpeed, _direction);
    var _move_y = lengthdir_y(playerSpeed, _direction);
    
    x += _move_x;
    y += _move_y;
}


x = clamp(x, PLAYER_CENTER, room_width - PLAYER_CENTER);
y = clamp(y, PLAYER_CENTER, room_height - PLAYER_CENTER);
