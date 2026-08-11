// Destroy ONE spikeball when this object is clicked
var spike = instance_find(obj_spikeball, 0);

if (spike != noone) {
    with (spike) instance_destroy();
}
