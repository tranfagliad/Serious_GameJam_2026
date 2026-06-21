
// Check for player collision with the given object, return booleans for x and y collisions
function CheckForPlayerCollision (_move_x, _move_y, _collision_object) {
	return {
		blockedX: place_meeting(x + _move_x, y, _collision_object),
		blockedY: place_meeting(x, y + _move_y, _collision_object)
	};
}
