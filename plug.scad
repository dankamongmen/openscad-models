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