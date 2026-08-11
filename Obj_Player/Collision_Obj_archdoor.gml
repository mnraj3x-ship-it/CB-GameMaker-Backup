/// Collision with Obj_archdoor

// Determine bounce direction based on which side she hit
var bounce_dir = x < other.x ? -1 : 1;

// Eject player horizontally
while (place_meeting(x + bounce_dir, y, Obj_archdoor)) {
    x += bounce_dir;
}

// Apply bounce
x += bounce_dir * 4; // adjust strength

// Do NOT flip her
// image_xscale stays the same

// Stop movement
hsp = 0;
