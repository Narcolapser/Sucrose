// This file provides the chute for the candy dispenser. 

module cut_pipe(height,outer_radius,inner_radius,cutoff) {
    difference() {
        cylinder(h=height,r=outer_radius);
        translate([0,0,-1])
            cylinder(h=height+2,r=inner_radius);
        translate([outer_radius-cutoff,-outer_radius,-1])
            cube([outer_radius*2,outer_radius*2,height+2]);
    }
}

module chute(inner_radius,outer_radius,chute_height,slant) {
//    inner_radius = 17;
//    outer_radius = 20;
//    chute_height = 100;
//    slant = 25;
    
    cutoff = 25;
    extension_length = 20;
    extension_slant = 10;

    // main chute down
    rotate([0,-slant,0])
        cut_pipe(chute_height,outer_radius,inner_radius,cutoff);

    // Elbow
//    translate([-1.8,0,0]) {
//        difference(){
//            sphere(r=outer_radius);
//            translate([-outer_radius,-outer_radius,0])
//                cube(outer_radius*2);
//            sphere(r=inner_radius);
//            translate([0,-outer_radius,-outer_radius])
//                cube(outer_radius*2);
//        }
//    }

    // Nicer elbow
    degrees = 90-slant;
    steps = 16;
    degrees_per_step = degrees/steps;
    for(i = [0:steps]) {
        rotate([0,-i*degrees_per_step-slant,0])
            translate([0,0,0])
                cut_pipe(20/steps,outer_radius,inner_radius,cutoff);
    }

    
    // Extension
    translate([extension_length-1.8,0,inner_radius-outer_radius])
        rotate([0,-90+extension_slant,0])
            cut_pipe(extension_length,outer_radius,inner_radius,cutoff);
    
    // dish
    translate([30,0,10]) {
        difference(){
            sphere(r=outer_radius*2);
            translate([-outer_radius*2,-outer_radius*2,-outer_radius])
                cube(outer_radius*4);
            sphere(r=inner_radius*2);
            translate([-15,0,-20])
                rotate([0,-90+extension_slant,0])
                    cylinder(h=20,r=inner_radius);
        }
    }
}

chute(17,20,100,25);