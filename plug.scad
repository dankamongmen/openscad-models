s=9.5;
t=10;
difference(){
    union(){
        cylinder(t, s, s);
        translate([0,-s,0]){
          cube([30,s*2,t]);
        }
        translate([30,0,0]){
          cylinder(t , s, s);
        }
    }
    union(){
        cylinder(15, 8, 8);
        translate([1, -8, 0]){
            cube([28, 16, 15]);
        }
        translate([30, 0, 0]){
            cylinder(15, 8, 8);
        }
    }
}
c=50;
translate([-10,-40.5,-12]){
    difference(){
        cube([c,c,12]);
        union(){
            translate([2.5, 0, 1]){
                cube([c - 5, c - 5, 10]);
            }
            translate([10,32,2]){
                cube([30,18,12]);
            }
        }
    }
}