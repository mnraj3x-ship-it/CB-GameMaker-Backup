// record sprite and mark as owned
has_rose = true;

// store the rose sprite directly for HUD rendering
rose_sprite = spr_rose;

// check if the rose has already been collected
if (!other.collected) {
    other.collected = true;
    instance_destroy(other); // or make invisible if you prefer
}