/// Alarm[0] Event - respawn same instance
// move back to spawn, restore health and a short invuln
x = spawn_x;
y = spawn_y;
currentHealth = maxHealth;
dead = false;
invincible = true;
invincible_timer = 60; // brief invul after respawn
hsp = 0;
vsp = 0;
on_ground = false;
facing = 1;
if (sprite_exists(spr_stand) && sprite_exists(spr_stand_left)) {
    sprite_index = (facing == 1) ? spr_stand : spr_stand_left;
}
image_speed = 0;