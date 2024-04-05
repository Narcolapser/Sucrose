include <Singulator.scad>
include <Singulator Shield.scad>

//mason_jar_inner_diameter = 60;
mason_jar_outer_diameter = 71;
skittle_diameter = 13;
//skittle_height = 9;
//motor_shaft_diameter = 5;
//motor_shaft_height = 6.5;
//motor_shaft_key_width = 3;

$fn = 256;

cuff_height = 25;
wall_thickness = 1;
//cuff_diameter = mason_jar_outer_diameter+wall_thickness*2;

//singulator(mason_jar_outer_diameter,skittle_diameter);
echo("Rendering shield");
singulator_shield(mason_jar_outer_diameter,cuff_height,skittle_diameter,wall_thickness);