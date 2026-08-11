// Reverse horizontal direction
hsp = -hsp;
image_xscale = -image_xscale;

// Eject player from block horizontally
while (place_meeting(x + sign(hsp), y, obj_block)) {
    x += sign(hsp);
}