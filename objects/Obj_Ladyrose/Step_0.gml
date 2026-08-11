// Make sure Obj_Player exists
if (instance_exists(Obj_Player)) {
    var target_x = Obj_Player.x;
    var target_y = Obj_Player.y;

    var angle = point_direction(x, y, target_x, target_y);

    // Move only if not too close
    if (point_distance(x, y, target_x, target_y) > follow_distance) {
        x += lengthdir_x(follow_speed, angle);
        y += lengthdir_y(follow_speed, angle);
    }
}