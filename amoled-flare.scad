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
            translate([flare + flarei, i * 15 + gap, 0]){
                cube([8, 5 - 2 * gap, depth]);
            }
        }
    }
    union(){
        translate([10, 5, 0]){
            hole_through("M3", l=1, cld=depth, h=10, hcld=1);
        }
        translate([10, 45, 0]){
            hole_through("M3", l=1, cld=depth, h=10, hcld=1);
        }
    }
}
