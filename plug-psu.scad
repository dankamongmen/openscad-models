s=7.5;
t=10;
// round element (plug)
difference(){
    union(){
        cylinder(t, s, s);
        translate([0,-s ,0]){
          cube([30,s*2  ,t]);
        }
        translate([30,0,0]){
          cylinder(t , s, s);
        }
    }
    union(){
        cylinder(15, s - 1, s- 1);
        translate([1, -6.5, 0]){
            cube([28, s*2 -2, 15]);
        }
        translate([30, 0, 0]){
            cylinder(15, s - 1, s - 1);
        }
    }
}
// cuboid element (cable guide)
c=50;
difference(){
    translate([-15, -61, -12]){
        difference(){
            cube([c+15,c+20,12]);
            union(){
                translate([15, 0, 1]){
                    cube([c - 15, c *2, 10]);
                }
                translate([12.5,s*6+9,2]){
                    cube([35, s * 2 - 1,12]);
                }
            }
        }
    }
    translate([0,0,-10]){
        cylinder(15, s - 1,  s-1);
        translate([1, -7.5, 0]){
            cube([28, s*2 -2, 15]);
        }
        translate([30, 0, 0]){
            cylinder(15, s - 1, s - 1);
        }
    }
}