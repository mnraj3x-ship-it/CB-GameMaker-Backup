if (instance_exists(obj_key)) {
    if (obj_key.collected) {
        visible = true;
    }
} else {
    // fallback in case obj_key was destroyed
    visible = true;
}
