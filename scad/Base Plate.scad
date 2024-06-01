// This file provides the baseplate of the candy dispenser. This holds the two circuit boards and screws into the bottom of the cuff.

include <Node Plate.scad>
$fn=256;
// the base plate itself.
module base_plate(plate_radius, wall_thickness) {
    difference() {
        union() {
            cylinder(wall_thickness,r=plate_radius);

            // The holders for the node and the driver
            translate([-25,-25,wall_thickness-2])
                node_plate();
            translate([-20,5,wall_thickness-2])
                driver_plate();
            }

        // Lastly the screw holes
        for(i=[0:3]) {
            rotate([0,0,90*i+45]) {
                translate([plate_radius-5,0,-0.1]){
                    cylinder(wall_thickness+1,d=3);
                }
            }
        }
        translate([plate_radius-12,-plate_radius,-0.1]) {
            cube(plate_radius*2);
        }
    }
}

//base_plate(50,3);