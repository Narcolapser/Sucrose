// Proof of concept spinning a cube for a screw.

mason_jar_inner_diameter = 60;
mason_jar_outer_diameter = 71;
skittle_diameter = 13;
skittle_height = 9;
motor_shaft_diameter = 5;
motor_shaft_height = 6.5;
motor_shaft_key_width = 3;
threading_height = 15;
thread_size = 1.5;
thread_pitch = 5.57;

$fn = 256;

cuff_height = 25;
wall_thickness = 1;
cuff_diameter = mason_jar_outer_diameter+wall_thickness*2;

// First the cuff
translate([0,0,-wall_thickness]) {
    
    difference() {
        cylinder(cuff_height,d=cuff_diameter);
        translate([0,0,-1])
            cylinder(cuff_height+2,d=cuff_diameter-wall_thickness*2);
        }
    
    // Cuff needs a base
    intersection() {
        cylinder(wall_thickness,d=cuff_diameter-1);
        translate([0,-cuff_diameter,0])
            cube([cuff_diameter*2,cuff_diameter*2,wall_thickness]);
        }
    
    // the key for the shield
    translate([-cuff_diameter/2+3,0,cuff_height/2-10+1])
        rotate([0,-90,0])
            cylinder(2,d=cuff_height/2,$fn=3);
}

translate([0,0,cuff_height-(thread_pitch*3)]){
    degrees = 360/$fn;
    thread_step = thread_pitch/$fn;
    for(i = [0:$fn*2]) {
        rotate([0,0,degrees*i]) {
            translate([mason_jar_outer_diameter/2-thread_size,-thread_size/2,thread_step*i]){
                cube(thread_size);
            }
        }
    }
}