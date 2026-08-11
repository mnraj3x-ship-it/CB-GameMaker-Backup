// === Monitor player health and restart room ===
if (instance_exists(Obj_Player)) {
    if (Obj_Player.currentHealth <= 0 && !Obj_Player.dead) {
        Obj_Player.dead = true;
        room_restart();
    }
}