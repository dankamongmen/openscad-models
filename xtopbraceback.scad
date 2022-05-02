include <cyl_head_bolt.scad>;
h = 2;
i = 7;
difference(){
    cube([30, 120, h]);
    union(){
        translate([i, i, 2]){
            screw("M4x12", thread="modeled");
        }
        translate([i, 120 - i, 2]){
            screw("M4x12", thread="modeled");
        }
        translate([20, 20, 0]){
            rotate([0, 0, 90]){
                linear_extrude(2){
                    text("schwarzgerät");
                }
            }
        }
    }
}
translate([0, -10, -23]){
    cube([30, 10, 25]);
}