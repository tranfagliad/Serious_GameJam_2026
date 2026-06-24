
followTarget = objPlayer;
//x = followTarget.x;	moved this to room start
//y = followTarget.y;



// If we don't like this we can get rid of it
zoomFactor = 0.7;
zoomWidth  = VIEWPORT_WIDTH * zoomFactor;
zoomHeight = VIEWPORT_HEIGHT * zoomFactor;
camera_set_view_size(view_camera[0], zoomWidth, zoomHeight);




