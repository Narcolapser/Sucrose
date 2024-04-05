
module singulator_shield(socket_diameter, socket_depth, candy_height, wall_thickness) {
    tweak_factor = 1.5;
    cuff_diameter = socket_diameter+wall_thickness*2;
    difference() {
        cylinder(candy_height*tweak_factor,d=(cuff_diameter-wall_thickness*2)-1);
        // interior
        translate([0,0,-1])
            cylinder(candy_height*tweak_factor,d=(cuff_diameter-wall_thickness*2)-1-wall_thickness);
            
        // top gap in shield
        intersection() {
            translate([cuff_diameter*0.1,-cuff_diameter/2,candy_height*tweak_factor-wall_thickness-0.1])
                cube(cuff_diameter);
            translate([0,0,5])
                cylinder(candy_height*tweak_factor,d=(cuff_diameter-wall_thickness*2)-1-wall_thickness);
        }
        
        // gap for key
        translate([-cuff_diameter/2+3,0,socket_depth/2-10])
            rotate([0,-90,0])
                cylinder(2,d=socket_depth/2+1,$fn=3); 
    }
    
}