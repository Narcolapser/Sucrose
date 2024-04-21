// This file provides the base plate for the NodeMCU to attach it to the rest of the dispenser.

test_print = true;

module stand_off(height,diameter,inner_diameter) {
    difference() {
        cylinder(h=height,d=diameter);
        translate([0,0,1])
            cylinder(h=height+2,d=inner_diameter);
    }
}

module node_plate() {
    screw_holes = 3;
    board_length = 48.2;
    screw_hole_length_inset = 1.94;
    board_width = 25.6;
    screw_hole_width_inset = 2.1;
    wall_thickness = 2;
    stand_off_height = 5;
    difference() {
        cube([board_length,board_width,wall_thickness]);
        if(test_print) {
            d = wall_thickness*2+screw_holes;
            translate([d,d,-1]) {
                cube([board_length-d*2,
                      board_width-d*2,
                      wall_thickness+2]);
            }
        }
    }
    translate([screw_hole_length_inset,
               screw_hole_width_inset,
               wall_thickness]) {
        for(i = [0:1]){
            for(j = [0:1]) {
                translate([i*(board_length-screw_hole_length_inset*2),
                           j*(board_width-screw_hole_width_inset*2),
                           0]) {
                    stand_off(stand_off_height,
                              screw_holes+wall_thickness,
                              screw_holes);
                }
            }
        }
    }
}

module driver_plate() {
    screw_holes = 3;
    board_length = 35.5;
    screw_hole_length_inset = 2.25;
    board_width = 31.4;
    screw_hole_width_inset = 2.25;
    wall_thickness = 2;
    stand_off_height = 5;
    
    difference() {
        cube([board_length,board_width,wall_thickness]);
        if(test_print) {
            d = wall_thickness*2+screw_holes;
            translate([d,d,-1]) {
                cube([board_length-d*2,
                      board_width-d*2,
                      wall_thickness+2]);
            }
        }
    }
    translate([screw_hole_length_inset,
               screw_hole_width_inset,
               wall_thickness]) {
        for(i = [0:1]){
            for(j = [0:1]) {
                translate([i*(board_length-screw_hole_length_inset*2),
                           j*(board_width-screw_hole_width_inset*2),
                           0]) {
                    stand_off(stand_off_height,
                              screw_holes+wall_thickness,
                              screw_holes);
                }
            }
        }
    }
}