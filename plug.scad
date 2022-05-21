
s=8.5;
t=10;
w=99;
h=88;
zh=15;
difference(){
    translate([-w/2 + 5, -20, -zh]){
        cube([w + 7, h, zh]);
    }
    union(){
        // main cavity, closed bottom
        translate([-(w-10)/2 + 7, -15, -(zh -2)]){
            cube([w - 3, h, zh - 5]);
        }
        // inlet on left side
        translate([55, -10, -(zh - 1)]){
            cube([10, 20, zh]);
        }
        // inlet on right side
        translate([-45, -10, -(zh - 1)]){
            cube([10, 20, zh]);
        }
        // area intersecting with plug
        translate([-15, -7.5, -3]){
            cube([30, 15, 3]);
        }
        // bottom of back is open
        translate([-15, -22.5, -10]){
            cube([29, 20, 10]);
        }
        // top of back is open
        translate([-42, 55, -5]){
            cube([w + 3, 15, 5]);
        }
    }
}
translate([45, -11, -15])
    rotate([0, 180, 0])
        linear_extrude(2)
            text("III", font="Liberation Sans:style=Bold Italic", size=70);
translate([55, 58, -15])
    rotate([180, 0, 270])
        linear_extrude(2)
            text("schwarzgerät", size=8.5);
// round element (plug)
difference(){
    union(){
        translate([-15, 0, 0]){
            cylinder(t, s, s);
        }
        translate([-15, -s , 0]){
          cube([30, s*2  ,t]);
        }
        translate([15, 0, 0]){
          cylinder(t , s, s);
        }
    }
    union(){
        translate([-15, -22.5, 0]){
            cube([23, 20, 20]);
        }
        translate([-15, 0, 0]){
            cylinder(15, s - 1, s- 1);
        }
        translate([-14, -9, 0]){
            cube([30, s*2 -2, 15]);
        }
        translate([15, 0, 0]){
            cylinder(15, s - 1, s - 1);
        }
    }
}
