// Obj_CameraController: Create Event
target = Obj_Player;
cam_width = camera_get_view_width(view_camera[0]);
cam_height = camera_get_view_height(view_camera[0]);

h_margin = cam_width * 0.3;  // Horizontal deadzone
v_margin = cam_height * 0.3; // Vertical deadzone

lerp_speed = 0.1; // Smoothness