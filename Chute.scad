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

inner_radius = 17;
outer_radius = 20;
cutoff = 25;
slant = 25;
rotate([0,-slant,0])
    cut_pipe(100,outer_radius,inner_radius,cutoff);

//for(i = [0:90-slant]) {
//    rotate([0,-i-slant,0])
//        translate([0,0,0])
//            cut_pipe(1,outer_radius,inner_radius,cutoff);
//}

difference(){
    sphere(r=outer_radius);
    translate([-outer_radius,-outer_radius,0])
        cube(outer_radius*2);
    sphere(r=inner_radius);
}