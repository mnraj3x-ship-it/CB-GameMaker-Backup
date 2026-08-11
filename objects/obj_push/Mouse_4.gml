// obj_push: Mouse Left Pressed
show_debug_message("obj_push clicked");

var lay = layer_get_id("Instances");
if (lay == -1) {
    show_debug_message("Layer 'Instances' not found");
} else {
    if (!instance_exists(obj_rose)) {
        var inst = instance_create_layer(x, y, lay, obj_rose);
        inst.parent_spawner = id; // optional: let rose know who made it
        show_debug_message("Created obj_rose at " + string(inst.x) + ", " + string(inst.y));
        with (inst) visible = true;
    } else {
        with (obj_rose) {
            visible = true;
            parent_spawner = other.id; // optional: link to this spawner
        }
        show_debug_message("obj_rose already exists; made visible");
    }
}