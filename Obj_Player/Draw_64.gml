/// obj_player Draw GUI — single top-left HUD, safe and minimal

// Guard: sprite present and sensible health
if (!sprite_exists(spr_health) || maxHealth <= 0) {
    draw_text(hud_x, hud_y, "HP: " + string(currentHealth) + " / " + string(maxHealth));
    return;
}

// Calculate HP per icon so we show desired_icons
var hp_icon = max(1, ceil(maxHealth / desired_icons));

// Scaled icon size and origin compensation (GUI coords)
var sx = hud_scale;
var icon_w = sprite_get_width(spr_health) * sx;
var icon_h = sprite_get_height(spr_health) * sx;
var ox = sprite_get_xoffset(spr_health) * sx;
var oy = sprite_get_yoffset(spr_health) * sx;

// Determine counts (cap to desired_icons)
var total_icons = max(1, ceil(maxHealth / hp_icon));
total_icons = min(total_icons, desired_icons);
var filled_icons = clamp(floor(currentHealth / hp_icon), 0, total_icons);

// Draw left-to-right so first icon top-left equals (hud_x, hud_y)
for (var i = 0; i < total_icons; i++) {
    var px = hud_x + i * (icon_w + hud_spacing) - ox;
    var py = hud_y - oy;
    if (i < filled_icons) {
        draw_sprite_ext(spr_health, 0, px, py, sx, sx, 0, c_white, 1);
    } else {
        draw_sprite_ext(spr_health, 0, px, py, sx, sx, 0, c_gray, 0.45);
    }
}

























// draw key in HUD if owned
if (has_key && spr_key != noone && sprite_exists(spr_key)) {
    var sx = hud_scale;
    // compute the icon position: put it after the health icons
    // health icons occupy 'total_icons' slots; reuse hud_spacing/icon_w
    var icon_w = sprite_get_width(spr_health) * sx;
    var px = hud_x + (total_icons) * (icon_w + hud_spacing);
    var py = hud_y;

    // you may want to scale the key differently — adjust sx_key
    var sx_key = sx;
    draw_sprite_ext(spr_key, 0, px, py, sx_key, sx_key, 0, c_white, 1);
}






// draw rose in HUD if owned
if (has_rose && spr_rose != noone && sprite_exists(spr_rose)) {
    var sx = hud_scale;
    var icon_w = sprite_get_width(spr_health) * sx;

    // place rose after the key (which is after health icons)
    var px = hud_x + (total_icons + 1) * (icon_w + hud_spacing);
    var py = hud_y;

    var sx_rose = sx; // adjust if you want rose to scale differently
    draw_sprite_ext(spr_rose, 0, px, py, sx_rose, sx_rose, 0, c_white, 1);
}