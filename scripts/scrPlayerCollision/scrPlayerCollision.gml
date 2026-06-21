
// Check for player collision with the given object, return booleans for x and y collisions
function CheckForPlayerCollision (_move_x, _move_y, _collision_object) {
	return {
		collidedX: place_meeting(x + _move_x, y, _collision_object),
		collidedY: place_meeting(x, y + _move_y, _collision_object)
	};
}
