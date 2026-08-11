var sx = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]);
var sy = random(camera_get_view_height(view_camera[0]));

instance_create_layer(sx, sy, "Instances", Obj_ghost);
