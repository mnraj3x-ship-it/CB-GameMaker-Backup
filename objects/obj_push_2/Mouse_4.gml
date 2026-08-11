// obj_push: Mouse Left Pressed
show_debug_message("obj_push clicked");

var lay = layer_get_id("Instances");
if (lay == -1) {
    show_debug_message("Layer 'Instances' not found");
} else {
    if (!instance_exists(obj_key)) {
        var inst = instance_create_layer(x, y, lay, obj_key);
        inst.parent_spawner = id; // optional: let key know who made it
        show_debug_message("Created obj_key at " + string(inst.x) + ", " + string(inst.y));
        with (inst) visible = true;
    } else {
        with (obj_key) {
            visible = true;
            parent_spawner = other.id; // optional: link to this spawner
        }
        show_debug_message("obj_key already exists; made visible");
    }
}

// destroy this spawner now that it has spawned/revealed the key
instance_destroy();

// Destroy all instances of Obj_Block
with (obj_block) {
    instance_destroy();
}