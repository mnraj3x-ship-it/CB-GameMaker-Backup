/// Check if player is under the doll
var player_under = instance_exists(Obj_Player)
    && abs(Obj_Player.x - x) < sprite_width * 0.5
    && Obj_Player.y > y;


// --- TIMER LOGIC ---
if (!is_dropping) {

    if (player_under) {
        stand_time++;
        swaying = true;

        // After required time → DROP
        if (stand_time >= required_time) {
            is_dropping = true;
            swaying = false;

            // Optional: small horizontal nudge toward player
            if (instance_exists(Obj_Player)) {
                var offset = 4;
                if (Obj_Player.x > x) x += offset;
                else if (Obj_Player.x < x) x -= offset;
            }
        }

    } else {
        stand_time = 0;
        swaying = false;
    }
}


// --- SWAY MOTION ---
if (swaying) {
    image_angle = sin(current_time * sway_speed) * sway_amount;
}


// --- DROP MOTION ---
if (is_dropping) {

    drop_speed += gravity_force;
    y += drop_speed;

    // Rotate while falling
    image_angle += drop_speed * 0.5;

    // Hit the ground?
    if (place_meeting(x, y, obj_solid)) {

        // Snap to ground
        while (!place_meeting(x, y + 1, obj_solid)) {
            y += 1;
        }
