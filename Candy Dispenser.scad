include <Singulator.scad>
include <Singulator Shield.scad>
include <Mason Jar Screw.scad>
include <Base Plate.scad>
include <Motor Plate.scad>

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
chassis_bottom_inner_radius = chassis_base_radius-wall_thickness-chassis_buffer;


$fn = 256;

//singulator(mason_jar_outer_diameter,skittle_diameter);
echo("Rendering shield");
//singulator_shield(mason_jar_outer_diameter,cuff_height,skittle_diameter,wall_thickness);

shield_offset = chassis_lug_width/2+5;

// chassis base
module base() {
    difference() {
        // base
        cylinder(h=chassis_height,chassis_base_radius,mason_jar_outer_diameter/2+wall_thickness);
        
        // hollow center
        translate([0,0,-0.1])
            cylinder(h=chassis_height-wall_thickness,chassis_bottom_inner_radius,mason_jar_outer_diameter/2);
        
        // top opening for the candy to fall
        difference() {
            // a cylinder to make the cut out
            cylinder(h=chassis_height+1,r=mason_jar_outer_diameter/2);
            // and then a cube to flatten said cylinder
            translate([0-chassis_height+shield_offset,-chassis_height/2,0])
                cube(chassis_height);
        }
        
        // and a hole for the motor
        cylinder(h=chassis_height+1,d=15);
        
        // cutouts for cables and candies
        translate([-chassis_base_radius,-chassis_opening_width/2,-0.1])
            cube([chassis_base_radius*2,chassis_opening_width,chassis_opening_height]);    
    }
}

module screw_lug(height,length){
    notch_depth = 5;
    translate([mason_jar_outer_diameter/2-length/2,0,-0.1]){
        difference() {
            translate([-notch_depth/2,-notch_depth/2,0.1])
                cube([length,notch_depth,height]);
            cylinder(height*2+1,d=3);
        }
    }
}

module base_with_lugs() {
    base();
    lug_height = 7.5;
    // The screw holes for mounting and the knotches for them.
    translate([0,0,chassis_height-7.5]){
        for(i=[0:1]) {
            rotate([0,0,i*180+90]) {
                screw_lug(lug_height,10);
            }        
        }
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

difference() {    
    union() {
        base_with_lugs();
        //translate([0,0,chassis_height]){
            //cuff()};

        plate_thickness = 10;
        translate([0,0,chassis_height-plate_thickness-wall_thickness]){
            motor_plate(plate_thickness, mason_jar_outer_diameter-2,mason_jar_outer_diameter/2-shield_offset);
        }
 
        plate_radius = chassis_base_radius - wall_thickness - chassis_buffer-2; 
        translate([0,0,5])
            base_plate(plate_radius,wall_thickness);
        
    }
    translate([-chassis_height,-chassis_height,7]){
        cube(chassis_height*2);
    }
}