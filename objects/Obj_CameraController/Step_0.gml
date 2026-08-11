// Obj_CameraController: Step Event
var _target_x = target.x;
var _target_y = target.y;

var _view_x = camera_get_view_x(view_camera[0]);
var _view_y = camera_get_view_y(view_camera[0]);

// Horizontal follow
if (_target_x < _view_x + h_margin) {
    _view_x = lerp(_view_x, _target_x - h_margin, lerp_speed);
} else if (_target_x > _view_x + cam_width - h_margin) {
    _view_x = lerp(_view_x, _target_x - cam_width + h_margin, lerp_speed);
}

// Vertical follow
if (_target_y < _view_y + v_margin) {
    _view_y = lerp(_view_y, _target_y - v_margin, lerp_speed);
} else if (_target_y > _view_y + cam_height - v_margin) {
    _view_y = lerp(_view_y, _target_y - cam_height + v_margin, lerp_speed);
}

// Clamp to room bounds
_view_x = clamp(_view_x, 0, room_width - cam_width);
_view_y = clamp(_view_y, 0, room_height - cam_height);

// Apply camera position
camera_set_view_pos(view_camera[0], _view_x, _view_y);