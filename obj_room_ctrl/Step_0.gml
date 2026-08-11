// obj_room_ctrl Step
// if already scheduled, do nothing
if (!watching_player) exit;

// if no player exists, schedule the transition
if (!instance_exists(Obj_Player)) {
    watching_player = false;
    alarm[0] = restart_delay;
}