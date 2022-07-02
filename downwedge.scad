use <wedge.scad>
use <joiner.scad>

translate([40, 30, 39]){
    fchunk(10, 1);
}
difference(){
    satawedge();
    translate([20, 30, 12]){
        rotate([0, 270, 0]){
            cylinder(140, 8, 9);
        }
    }
}