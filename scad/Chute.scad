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

module chute(inner_radius,outer_radius,chute_height,slant,dish_width,dish_height) {
//    inner_radius = 17;
//    outer_radius = 20;
//    chute_height = 100;
//    slant = 25;
    
    cutoff = 25;
    extension_length = 15;
    extension_slant = 15;

    translate([0,0,5+dish_height]) {
        // main chute down
        difference() {
            rotate([0,-slant,0])
                cut_pipe(chute_height*2,outer_radius,inner_radius,cutoff);
            translate([-outer_radius*10,-outer_radius*5,chute_height]) {
                cube(outer_radius*10);
            }
        }

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
                    cut_pipe(25/steps,outer_radius,inner_radius,cutoff);
        }

        
        // Extension
        difference() {
            translate([extension_length-1.8,0,inner_radius-outer_radius])
                rotate([0,-90+extension_slant,0])
                    cut_pipe(extension_length,outer_radius,inner_radius,cutoff);
            
        }
    }
    difference() {
        // The dish
        translate([-5,-dish_width/2,]) {
            minkowski(){
                cube([dish_width+5,dish_width,0.01]);
                cylinder(h=dish_height,5,0,$fn=8);
            }
        }

        // Extension
        translate([extension_length-1.8,0,inner_radius-outer_radius+5+dish_height])
                rotate([0,-90+extension_slant,0])
                    cylinder(extension_length+4,r=outer_radius);
        
        // bowl
        translate([dish_width/2,0,dish_width/2])
            sphere(d=dish_width);
        
    }
}

//chute(17,20,100,25,50,20);