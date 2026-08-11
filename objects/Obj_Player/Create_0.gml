lever_used = false;
lever_lock_timer = 0;
lever_used = false;

/// ===============================
/// === OBJ_PLAYER — CREATE EVENT ===
/// ===============================

// === Core movement & physics ===
hsp = 0;
vsp = 0;
walk_speed = 4;
run_speed = 6;        // Gex-style run
jump_speed = -10;
gravity_down = 0.6;
gravity_up = 0.35;
jump_cut = 0.5;
terminal_vel = 12;
on_ground = false;
facing = 1;

// === Jump buffer & coyote ===
jump_buffer = 0;
jump_buffer_time = 10;
coyote_counter = 0;
coyote_time = 10;

// === Attack system ===
attack_active = false;
attack_timer  = 0;
attack_type   = "";

// === Karate kick ===
kick_active = false;
kick_timer  = 0;

// === Bounce attack ===
bounce_active = false;
bounce_timer  = 0;
bounce_ready  = false;

// === Interaction flags (NEW) ===
lever_active = false;
chest_active = false;

// === State flags ===
dead = false;
collected = false;

// === Health ===
currentHealth = 100;
maxHealth = 100;
invincible = false;
invincible_timer = 0;

// === Inventory ===
has_key = false;
key_sprite = noone;
key_hud_index = 0;

has_rose = false;
rose_sprite = noone;
rose_hud_index = 0;

// === HUD ===
hud_x = 8;
hud_y = 8;
hud_scale = 0.35;
hud_spacing = 4;
desired_icons = 5;
hp_per_icon = 20;

// === Rose globals ===
global.has_rose = false;
global.spr_rose = noone;

// === Run-up timer (Gex-style) ===
run_timer = 0;
run_time_threshold = 18;   // how long before auto-run
running = false;
