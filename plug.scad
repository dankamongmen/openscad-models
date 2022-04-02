difference(){
    union(){
        cylinder(10, 10, 10);
        translate([0,-10,0]){
          cube([30,20,10]);
        }
        translate([30,0,0]){
          cylinder(10, 10, 10);
        }
    }
    union(){
        cylinder(10, 8, 8);
        translate([1, -8, 0]){
            cube([28, 16, 10]);
        }
        translate([30, 0, 0]){
            cylinder(10, 8, 8);
        }
    }
}
difference(){
    translate([15,0,0]){
        rotate([0,0,270]){
            cylinder(r=55, h=5, $fn=3);
        }
    }
    union(){
        translate([15,0,1]){
            rotate([0,0,270]){
                cylinder(r=50, h=3, $fn=3);
            }
        }
        translate([-20, 10, 1]){
            cube([70, 35,3]);
        }
        translate([0, -40, 1]){
            cube([40,10,3]);
        }
    }
}
