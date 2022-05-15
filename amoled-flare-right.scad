// flare for back of AMOLED brace
// on right side, we need a gap through which
// we'll run the screen's power cable
// TODO: extract common values into a distinct file

include <cyl_head_bolt.scad>

flare = 11;
flarei = 5;
backdepth = 11;
depth = backdepth - 0.5;
eh = 87; // device height
gap = 0.3; // fitting tolerance

difference(){
    union(){
        cube([flare + flare - 1, eh, depth]);
        for(i = [1:5]){
            translate([flare + flarei, i * 15 + gap, 0]){
                cube([8, 5 - 2 * gap, depth]);
            }
        }
    }
    union(){
        for(i = [23, 37, 63, 79]){
            translate([10, i, 0]){
                rotate([180, 0, 90]){
                    hole_through("M4", l=100, cld=0.1, h=1, hcld=1);
                }
            }
        }
        translate([0, eh - 2, 0]){
            cylinder(h = depth * 2 + 1, r = 6, center = true);
        }
    }
}
