// flares for back of AMOLED brace
//
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
            translate([-8, i * 15 + gap, 0]){
                cube([8, 5 - 2 * gap, depth]);
            }
        }
    }
    union(){
        for(i = [23, 37, 63, 79]){
            translate([10, i, -2]){
                rotate([180, 0, 90]){
                    hole_through("M4", l=100, cld=0.1, h=1, hcld=1);
                }
            }
        }
    }
}
