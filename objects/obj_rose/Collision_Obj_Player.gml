global.has_rose = true;

// Spawn the rose door at a specific location
instance_create_layer(320, 160, "Instances", obj_rose_door);

// Remove the rose
instance_destroy();