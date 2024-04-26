include <Singulator.scad>
include <Singulator Shield.scad>
include <Mason Jar Screw.scad>

mason_jar_outer_diameter = 71;
skittle_diameter = 13;
cuff_height = 25;
wall_thickness = 3;

chassis_height = 75;
chassis_buffer = 2;
chassis_base_radius = 50 + wall_thickness + chassis_buffer;
chassis_opening_width = chassis_base_radius;
chassis_opening_height = 25;
chassis_lug_width = 10;


$fn = 256;

//singulator(mason_jar_outer_diameter,skittle_diameter);
echo("Rendering shield");
//singulator_shield(mason_jar_outer_diameter,cuff_height,skittle_diameter,wall_thickness);

// chassis base
module base() {
    difference() {
        // base
        cylinder(h=chassis_height,chassis_base_radius,mason_jar_outer_diameter/2+wall_thickness);
        
        // hollow center
        translate([0,0,-0.1])
            cylinder(h=chassis_height-0.1,chassis_base_radius-wall_thickness-chassis_buffer,mason_jar_outer_diameter/2);
        
        // top opening for the candy to fall
        difference() {
            // a cylinder to make the cut out
            cylinder(h=chassis_height+1,r=mason_jar_outer_diameter/2);
            // and then a cube to flatten said cylinder
            translate([0-chassis_height+chassis_lug_width/2,-chassis_height/2,0])
                cube(chassis_height);
        }
        
        // and a hole for the motor
        cylinder(h=chassis_height+1,d=15);
        
        // cutouts for cables and candies
        translate([-chassis_base_radius,-chassis_opening_width/2,-0.1])
            cube([chassis_base_radius*2,chassis_opening_width,chassis_opening_height]);    
    }
}


// chassis cuff
module cuff() {
    cuff_diameter = mason_jar_outer_diameter+wall_thickness*2;
    shield_height = 16;
    thread_size = 1.5;
    inner_cuff_diameter = cuff_diameter-wall_thickness*2-thread_size*2;
    key_thickness = 2;
    
    // base cylinder
    difference() {
        cylinder(h=shield_height,d=cuff_diameter);
        translate([0,0,-0.1])
            cylinder(h=shield_height+1,d=inner_cuff_diameter);
    }
    
    // Shield key
    translate([-inner_cuff_diameter/2+key_thickness,0,2])
        rotate([0,-90,0])
            cylinder(key_thickness,d=shield_height/2,$fn=3); 

    // mason jar screw
    translate([0,0,shield_height-thread_size])
        screw_attachment(16,wall_thickness);
}


    
base();
//translate([0,0,chassis_height])
//    cuff();