/// === Obj_Player Step Event ===

/// ===============================
/// === INTERACTION SYSTEM ========
/// ===============================

// --- LEVER INTERACTION ---
var lever = instance_place(x, y, obj_lever);

if (lever != noone && keyboard_check_pressed(vk_down)) {

    lever_active = true;
    chest_active = false;

    // Use left or right open sprite
    sprite_index = (facing == 1) ? spr_open : spr_open_l;
    image_index = 0;
    image_speed = 0.3;

    with (lever) {
        sprite_index = spr_lever_active;
        image_speed = 0;
        activated = true;
    }
}


// --- LEVER INTERACTION ---
var lever = instance_place(x, y, obj_lever_rosesaw);

if (lever != noone && keyboard_check_pressed(vk_down)) {

    lever_active = true;
    chest_active = false;

    // Use left or right open sprite
    sprite_index = (facing == 1) ? spr_open : spr_open_l;
    image_index = 0;
    image_speed = 0.3;

    with (lever) {
        sprite_index = spr_lever_active;
        image_speed = 0;
        activated = true;
    }
}



// --- LEVER INTERACTION ---
var lever = instance_place(x, y, obj_lever_spikes);

if (lever != noone && keyboard_check_pressed(vk_down)) {

    lever_active = true;
    chest_active = false;

    // Use left or right open sprite
    sprite_index = (facing == 1) ? spr_open : spr_open_l;
    image_index = 0;
    image_speed = 0.3;

    with (lever) {
        sprite_index = spr_lever_active;
        image_speed = 0;
        activated = true;
    }
}




// --- CHEST INTERACTION ---
var chest = instance_place(x, y + 8, Obj_chest);

if (chest != noone && keyboard_check_pressed(vk_down)) {

    chest_active = true;
    lever_active = false;

    chest.is_open = true;

    // Use left or right open sprite
    sprite_index = (facing == 1) ? spr_open : spr_open_l;
    image_index = 0;
    image_speed = 0.3;
}

// --- FINISH OPEN ANIMATION ---
if ((sprite_index == spr_open || sprite_index == spr_open_l) && image_index >= image_number - 1) {
    lever_active = false;
    chest_active = false;

    // Return to correct standing sprite
    sprite_index = (facing == 1) ? spr_stand : spr_stand_left;
    image_speed = 0;
}

// === LOCK OPEN ANIMATION ===
// Prevent ANY other animation from overriding spr_open / spr_open_l
if (sprite_index == spr_open || sprite_index == spr_open_l) {
    return;
}


// === Spawn position fallback ===
if (!variable_instance_exists(id, "spawn_x")) {
    spawn_x = x;
    spawn_y = y;
}

// === Early exit if dead ===
if (dead) return;


// ===============================
// === INPUT =====================
// ===============================
var move = 0;

if (keyboard_check(vk_right)) {
    move = 1;
    facing = 1;
}
else if (keyboard_check(vk_left)) {
    move = -1;
    facing = -1;
}

// === Jump buffer ===
if (keyboard_check_pressed(vk_up)) {
    jump_buffer = jump_buffer_time;
}


// ===============================
// === MOVEMENT ==================
// ===============================
var accel_ground = 0.55;
var accel_air    = 0.30;
var decel        = 0.40;

if (move != 0) {
    hsp = lerp(hsp, move * walk_speed, on_ground ? accel_ground : accel_air);
} else {
    hsp = lerp(hsp, 0, decel);
}

if (!is_real(hsp)) hsp = 0;
if (!is_real(vsp)) vsp = 0;


// === Gravity ===
var g = gravity_down;

// === Jump‑cut ===
if (vsp < 0) {
    g = keyboard_check(vk_up) ? gravity_up : gravity_down * jump_cut;
}

vsp += g;
vsp = clamp(vsp, -abs(jump_speed), terminal_vel);


// === Coyote time ===
if (on_ground) coyote_counter = coyote_time;
else coyote_counter = max(coyote_counter - 1, 0);


// === Jump trigger ===
if (jump_buffer > 0 && (on_ground || coyote_counter > 0)) {

    vsp = jump_speed;
    on_ground = false;
    coyote_counter = 0;
    jump_buffer = 0;

    if (place_meeting(x, y + 1, obj_solid)) y -= 1;

    sprite_index = (facing == 1) ? spr_jump_right : spr_jump_left;
    image_speed = 0.25;
}
else {
    jump_buffer = max(jump_buffer - 1, 0);
}


// =========================================================
// === GEX‑STYLE SLAP ATTACK ===============================
// =========================================================

if (keyboard_check_pressed(vk_space) && !attack_active && !dead) {

    attack_active = true;
    attack_timer  = 16;
    attack_type   = "slap";

    if (move != 0) facing = move;

    var hx = x + (facing * 16);
    instance_create_layer(hx, y, "Instances", obj_hitbox);

    if (on_ground) {
        hsp = facing * (walk_speed + 1.5);
    } else {
        vsp = clamp(vsp - 2, -abs(jump_speed), terminal_vel);
    }

    sprite_index = (facing == 1) ? spr_slap_right : spr_slap_left;
    image_speed  = 0.45;
}

// === Attack Timer ===
if (attack_active) {

    attack_timer--;

    sprite_index = (facing == 1) ? spr_slap_right : spr_slap_left;
    image_speed  = 0.45;

    if (attack_timer <= 0) {
        attack_active = false;
        attack_type   = "";
    }

    return;
}


// =========================================================
// === COLLISION ===========================================
// =========================================================

var safety = 256;
var safety_v = 512;

// === Horizontal collision with step-up ===
if (hsp != 0) {
    var move_sign = sign(hsp);
    var steps = floor(abs(hsp));

    var local_safety = safety;

    while (steps > 0 && local_safety > 0) {
        local_safety--;

        if (!place_meeting(x + move_sign, y, obj_solid)) {
            x += move_sign;
            steps--;
            continue;
        }

        var stepped = false;
        var max_step = 6;

        if (on_ground) {
            for (var s = 1; s <= max_step; s++) {
                if (!place_meeting(x, y - s, obj_solid) &&
                    !place_meeting(x + move_sign, y - s, obj_solid)) {

                    y -= s;
                    x += move_sign;
                    steps--;
                    stepped = true;
                    break;
                }
            }
        }

        if (stepped) continue;

        hsp = 0;
        break;
    }

    safety = local_safety;
}

if (safety <= 0) hsp = 0;


// === Vertical collision ===
var vstep = sign(vsp);

if (vsp != 0 && vstep != 0) {
    var vsteps = floor(abs(vsp));
    var local_safety_v = safety_v;

    if (place_meeting(x, y + vsp, obj_solid)) {
        while (vsteps > 0 && local_safety_v > 0) {
            local_safety_v--;

            if (!place_meeting(x, y + vstep, obj_solid)) {
                y += vstep;
                vsteps--;
            } else break;
        }

        if (vstep > 0) on_ground = true;
        vsp = 0;
    } else {
        on_ground = false;
        y += vsp;
    }

    safety_v = local_safety_v;

    if (safety_v <= 0) {
        vsp = 0;
        var unstuck = 0;
        while (place_meeting(x, y, obj_solid) && unstuck < 64) {
            y -= 1;
            unstuck++;
        }
    }
} else {
    on_ground = place_meeting(x, y + 1, obj_solid);
}


// =========================================================
// === SPRITE ANIMATION ====================================
// =========================================================

// Prevent override during lever/chest animation
if (lever_active || chest_active) {
    return;
}

if (!on_ground) {
    if (vsp > 0) {
        sprite_index = (facing == 1) ? spr_fall_right : spr_fall_left;
    } else {
        sprite_index = (facing == 1) ? spr_jump_right : spr_jump_left;
    }
    image_speed = 0.25;
}
else {
    if (move != 0) {
        sprite_index = (facing == 1) ? spr_walk_right : spr_walk_left;
        image_speed = 0.35;
    } else {
        sprite_index = (facing == 1) ? spr_stand : spr_stand_left;
        image_speed = 0;
    }
}


// =========================================================
// === DAMAGE HANDLER ======================================
// =========================================================

var hazard = instance_place(x, y, obj_spikeball);
if (hazard == noone) hazard = instance_place(x, y, obj_spikes);

if (hazard != noone && !invincible && !dead) {

    var dmg = max(1, ceil(currentHealth * 0.5));
    currentHealth -= dmg;

    invincible = true;
    invincible_timer = 30;

    sprite_index = (facing == 1) ? spr_hurt_right : spr_hurt_left;
    image_speed = 0.2;

    if (currentHealth <= 0) {
        currentHealth = 0;
        dead = true;
        hsp = 0;
        vsp = 0;
        invincible = false;

        sprite_index = (facing == 1) ? spr_dead_right : spr_dead_left;
        image_speed = 0;

        death_timer = 30;
        alarm[0] = death_timer;
    }
}

// === Invincibility timer ===
if (invincible) {
    invincible_timer--;
    if (invincible_timer <= 0) invincible = false;
}
