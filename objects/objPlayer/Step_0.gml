// Detect Inputs
var _input_x = objInputManager.held.right - objInputManager.held.left;
var _input_y = objInputManager.held.down - objInputManager.held.up;


// Spin
isSpinning = objInputManager.held.space;
if (isSpinning) {
	image_angle += spinSpeed;
	
	PlayerTornadoScan(PLAYER_WIDTH);
}
// Reset orientation?
/*else {
	image_angle = 0;
}
*/


// Player Movement
if (_input_x != 0 || _input_y != 0) {

    var _direction = point_direction(0, 0, _input_x, _input_y);
    
    var _move_x = lengthdir_x(playerSpeed, _direction);
    var _move_y = lengthdir_y(playerSpeed, _direction);
	
	// Check for collisions with tables
	var _collision = CheckForPlayerCollision(_move_x, _move_y, objParentTable);
	x = _collision.blockedX ? x : x + _move_x;
	y = _collision.blockedY ? y : y + _move_y;
	
	
    
    //x += _move_x;
    //y += _move_y;
}


// Do not leave the bounds of the level
x = clamp(x, PLAYER_CENTER, room_width - PLAYER_CENTER);
y = clamp(y, PLAYER_CENTER, room_height - PLAYER_CENTER);
