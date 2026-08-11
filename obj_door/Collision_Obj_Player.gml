if (global.has_key && global.has_rose)
{
    room_goto(Part_2_level_1);
}
else if (global.has_key && !global.has_rose)
{
    room_goto(Death_room);
}




if (!global.has_rose)
{
    room_goto(Death_room);
}