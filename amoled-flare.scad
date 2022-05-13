// flares for back of AMOLED brace
//
// TODO: extract common values into a distinct file

include <cyl_head_bolt.scad>

flare = 11;
flarei = 5;
backdepth = 11;
eh = 87; // device height
gap = 0.15; // fitting tolerance

difference(){
    union(){
        cube([flare + flare - 1, eh, backdepth]);
        for(i = [1:5]){
            translate([flare + flarei, i * 15 + gap, 0]){
                cube([10, 5 - 2 * gap, backdepth]);
            }
        }
    }
    union(){
        translate([15, 40, 0]){
            hole_through(name="M4", l = 50, cld = 0.1, h = 10, hcld = 0.4);
        }
    }
}
