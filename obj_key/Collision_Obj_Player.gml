if (!collected) {
    collected = true;
    global.has_key = true;
    global.spr_key = spr_key;
    instance_destroy();
}



global.has_key = true;

// Destroy the rose door if it exists
with (obj_rose_door)
{
    instance_destroy();
}

instance_destroy(); // Remove the key