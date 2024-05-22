$fn = 256;

module singulator(socket_diameter,candy_diameter,candy_height){
    // Static values for the singulator
    motor_shaft_diameter = 5.5;
    motor_shaft_height = 11;
    motor_shaft_key_width = 3.2;
    margin = 2;
    holes = 8;
    tweak_factor = 1.1;
    
    // Calculated values
    singulator_diameter = socket_diameter - margin * 2;
    degree_spread = 360/holes;
    
    difference() {
        cylinder(candy_height*tweak_factor,d=singulator_diameter);
        for(i=[0:holes]) {
            rotate([0,0,degree_spread*i])
                translate([0,singulator_diameter/2-candy_diameter+5,-1])
                    cylinder(h=candy_diameter*tweak_factor+2,d=candy_diameter*tweak_factor);
        }
        
        // motor shaft
        translate([0,0,-0.1])
            intersection() {
                cylinder(h=motor_shaft_height,d=motor_shaft_diameter);
                cube([motor_shaft_diameter,motor_shaft_key_width,motor_shaft_height*2],center=true);
            }
        
    }
}

mason_jar_outer_diameter = 67.38;
skittle_diameter = 13;
skittle_height = 9;
cuff_height = 25;
wall_thickness = 3;

singulator(mason_jar_outer_diameter,skittle_diameter,skittle_height);