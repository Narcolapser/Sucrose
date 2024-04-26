// This file represents the plate that holds the stepper motor that drives the singulator. The motor screws in from the top but the plate screws in from the bottom to the cuff. 

plate_thickness = 10;
plate_diameter = 60;

motor_height = 19.5;
motor_diameter = 29.5;
motor_bump_diameter = 9.2;
motor_bump_height = 1.5;
center_to_center_offset = 7.75;
ear_width = 7.25;
ear_length = 35;

$fn = 256;

module stepper() {
    cylinder(h=motor_height,d=motor_diameter);
    translate([0,center_to_center_offset,motor_height])
        cylinder(h=motor_bump_height,d=motor_bump_diameter);
    translate([0,0,motor_height-1]) {
        translate([-ear_length/2,-ear_width/2,0])
            cube([ear_length,ear_width,1]);
        translate([ear_length/2,0,0])
            cylinder(1,d=ear_width);
        translate([-ear_length/2,0,0])
            cylinder(1,d=ear_width);
            
        // screw holes
        translate([ear_length/2,0,-motor_height+0.1])
            cylinder(motor_height,d=3);
        translate([-ear_length/2,0,-motor_height+0.1])
            cylinder(motor_height,d=3);
    }
    
    //the wiring connection
    cable_bump_width = 18;
    translate([-cable_bump_width/2,-20,0]) {
        cube([cable_bump_width,cable_bump_width,motor_height]);
    }
}

difference() {
    // The plate itself
    cylinder(h=plate_thickness, d=plate_diameter);


    // The cut out for the stepper motor
    translate([0,-center_to_center_offset,plate_thickness-motor_height+0.1]) {
        stepper();
    }
    
    // The screw holes for mounting and the knotches for them.
    // Rework this. Instead of making each one, make it in a for loop and rotate them around.
    for(i=[0:2]) {
        rotate([0,0,i*90])
            translate([25,0,-0.1]){
                cylinder(plate_thickness+1,d=3);
                translate([-3.5,-3.5,plate_thickness/2+0.2])
                    cube([9,7,plate_thickness/2]);
            }
    }
}

