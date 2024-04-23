// This file provides the baseplate of the candy dispenser. This holds the two circuit boards and screws into the bottom of the cuff.

include <Node Plate.scad>
$fn=256;
// the base plate itself.
module base_plate() {
    wall_thickness = 3;
    plate_radius = 50;
    difference() {
        union() {
            cylinder(wall_thickness,r=plate_radius);

            // The holders for the node and the driver
            translate([-25,-30,wall_thickness-2])
                node_plate();
            translate([-25,0,wall_thickness-2])
                driver_plate();
            }

        // Lastly the screw holes
        union() {
            translate([45,0,-0.1])
                cylinder(wall_thickness+1,d=3);

            translate([0,45,-0.1])
                cylinder(wall_thickness+1,d=3);

            translate([-45,0,-0.1])
                cylinder(wall_thickness+1,d=3);

            translate([0,-45,-0.1])
                cylinder(wall_thickness+1,d=3);
        }
    }
}

base_plate();