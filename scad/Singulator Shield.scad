$fn = 256;

module singulator_shield(socket_diameter, socket_depth, candy_height, wall_thickness) {
    tweak_factor = 1.1;
    cuff_diameter = socket_diameter+wall_thickness*2;
    difference() {
        cylinder(candy_height*tweak_factor,d=(cuff_diameter-wall_thickness*2)-1);
        // interior
        translate([0,0,-1])
            cylinder(candy_height*tweak_factor,d=(cuff_diameter-wall_thickness*2)-3);
            
        // top gap in shield
        intersection() {
            translate([cuff_diameter*0.1,-cuff_diameter/2,candy_height*tweak_factor-wall_thickness-0.1])
                cube(cuff_diameter);
            translate([0,0,5])
                cylinder(candy_height*tweak_factor,d=(cuff_diameter-wall_thickness*2)-3);
        }
        // gap for key
        translate([cuff_diameter/2,0,1.5])
            rotate([0,-90,0])
                cylinder(20,d=socket_depth/2+1,$fn=3); 
        }
    
}

mason_jar_outer_diameter = 67.38;
skittle_diameter = 13;
skittle_height = 9;
cuff_height = 14;
wall_thickness = 3;

// singulator_shield(mason_jar_outer_diameter,cuff_height,skittle_height,wall_thickness);