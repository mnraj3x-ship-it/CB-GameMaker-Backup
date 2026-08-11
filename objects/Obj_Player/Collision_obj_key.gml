// record sprite and mark as owned
has_key = true;

// store the sprite from the key instance so we can render it in the HUD
key_sprite = other.sprite_index;

if (!obj_key.collected) {
    obj_key.collected = true;
    instance_destroy(obj_key); // or make invisible if you prefer
}

// destroy the key instance we collided with
with (other) instance_destroy();