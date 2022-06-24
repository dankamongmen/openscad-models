include <cyl_head_bolt.scad>;
h = 3;
i = 10;
i2 = 5;
sh=2;
w=128;
difference(){
    cube([30, w, h]);
    union(){
        translate([i, i, sh]){
            screw("M4x12", thread="modeled");
        }
        translate([i2, i2, sh]){
            screw("M4x12", thread="modeled");
        }
        translate([i, w - i, sh]){
            screw("M4x12", thread="modeled");
        }
        translate([i2, w - i2, sh]){
            screw("M4x12", thread="modeled");
        }
        translate([65, w/2 - 5, 0]){
            sphere(r=50);
        }
    }
}

translate([0, -10, 0]){
    cube([30, 10, h]);
}
