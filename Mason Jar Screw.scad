// This file simply creates a cylinder with a mason jar screw in it.

module screw_attachment(cuff_height, wall_thickness) {
    // tweaks
    mason_jar_outer_diameter = 71;
    thread_size = 1.5;
    thread_pitch = 5.57;
    res = 256;

    // calculated
    cuff_diameter = mason_jar_outer_diameter+wall_thickness*2;
    degrees = 360/res;
    thread_step = thread_pitch/res;
    laps = (cuff_height / thread_pitch)-0.5;

    // First the cuff
    difference() {
        cylinder(cuff_height,d=cuff_diameter);
        translate([0,0,-1])
            cylinder(cuff_height+2,d=cuff_diameter-wall_thickness*2);
        }

    for(i = [0:res*laps]) {
        rotate([0,0,degrees*i]) {
            translate([mason_jar_outer_diameter/2-thread_size,
                       -thread_size/2,
                       thread_step*i]){
                cube(thread_size);
            }
        }
    }
}

// inputs
screw_attachment(16,1);
//cuff_height = 16;
//wall_thickness = 1;