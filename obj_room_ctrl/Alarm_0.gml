// obj_room_ctrl Alarm 0
// double-check player is still gone, then go to previous room
if (!instance_exists(Obj_Player)) {
    room_goto_previous();
} else {
    // player returned / respawned; resume watching
    watching_player = true;
}